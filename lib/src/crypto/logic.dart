import 'dart:convert';
import 'dart:typed_data';

import 'package:algorand_dart/algorand_dart.dart';
import 'logic_opcodes.dart';

class Logic {
  static LangSpec? langSpec;
  static const MAX_COST = 20000;
  static const MAX_LENGTH = 1000;

  static final OPCODES_SIZE_FUN = const <int,
      (IntConstBlock?, ByteConstBlock?) Function(Uint8List program, int pc)>{
    32: LogicOpcodes.intcblock_size,
    38: LogicOpcodes.bytecblock_size,
    128: LogicOpcodes.pushbytes_size,
    129: LogicOpcodes.pushint_size,
    130: LogicOpcodes.pushbytess_size,
    131: LogicOpcodes.pushints_size,
    141: LogicOpcodes.switch_size,
    142: LogicOpcodes.match_size,
  };

  /// Perform basic program validation; instruction count and program cost
  static bool checkProgram({
    required Uint8List program,
    required List<Uint8List>? arguments,
  }) {
    return readProgram(program: program, arguments: arguments ?? []).good;
  }

  /// Performs basic program validation: instruction count and program cost
  static ProgramData readProgram({
    required Uint8List program,
    required List<Uint8List> arguments,
  }) {
    final ints = <int>[];
    final bytes = <Uint8List>[];
    if (langSpec == null) {
      loadLangSpec();
    }

    final result = getUVarint(program, 0);
    var vlen = result.length;
    var version = result.value;
    if (vlen <= 0) {
      throw AlgorandException(message: 'Version parsing error');
    }

    if (version > langSpec!.version) {
      throw AlgorandException(message: 'Unsupported version');
    }

    var cost = 0;
    var length = program.length;
    for (var i = 0; i < arguments.length; i++) {
      length += arguments[i].length;
    }

    if (length > MAX_LENGTH) {
      throw AlgorandException(message: 'program too long');
    }

    final opcodes = List<Operation?>.filled(256, null);
    for (var i = 0; i < langSpec!.operations.length; i++) {
      var op = langSpec!.operations[i];
      opcodes[op.opCode] = op;
    }

    var pc = vlen;
    while (pc < program.length) {
      var opcode = program[pc];
      var op = opcodes[opcode];
      if (op == null) {
        throw AlgorandException(message: 'invalid instruction: $opcode');
      }

      cost += op.opCost.cost;
      var size = op.size;
      if (size == 0) {
        final fun = OPCODES_SIZE_FUN[op.opCode];
        if (fun == null) {
          throw AlgorandException(message: 'invalid instruction');
        }

        final (intsBlock, bytesBlock) = fun(program, pc);
        ints.addAll(intsBlock?.results ?? []);
        size += intsBlock?.size ?? 0;
        bytes.addAll(bytesBlock?.results ?? []);
        size += bytesBlock?.size ?? 0;
      }

      pc += size;
    }

    // costs calculated dynamically starting in v4
    if (version < 4 && cost > MAX_COST) {
      throw AlgorandException(
        message: 'program too costly for Teal version < 4. consider using v4.',
      );
    }

    return ProgramData(good: true, intBlock: ints, byteBlock: bytes);
  }

  static void loadLangSpec() {
    if (langSpec != null) {
      return;
    }

    final data = jsonDecode(LANG_SPEC) as Map<String, dynamic>;
    langSpec = LangSpec.fromJson(data);
  }

  /// Retrieves max supported version of TEAL evaluator
  static int get evalMaxVersion {
    if (langSpec == null) {
      loadLangSpec();
    }

    return langSpec?.version ?? 0;
  }

  /// Retrieves TEAL supported version
  static int get logicSigVersion {
    if (langSpec == null) {
      loadLangSpec();
    }

    return langSpec?.logicSigVersion ?? 0;
  }

  /// Given a varint, get the integer value
  static VarintResult getUVarint(Uint8List buffer, int bufferOffset) {
    var x = 0;
    var s = 0;

    for (var i = 0; i < buffer.length; i++) {
      var b = buffer[bufferOffset + i];
      if (b < 0x80) {
        if (i > 9 || i == 9 && b > 1) {
          return VarintResult(0, -(i + 1));
        }
        return VarintResult(x | (b & 0xff) << s, i + 1);
      }
      x |= ((b & 0x7f) & 0xff) << s;
      s += 7;
    }
    return VarintResult();
  }

  /// Varints are a method of serializing integers using one or more bytes.
  /// Smaller numbers take a smaller number of bytes.
  /// Each byte in a varint, except the last byte, has the most significant
  /// bit (msb) set – this indicates that there are further bytes to come.
  /// The lower 7 bits of each byte are used to store the two's complement
  /// representation of the number in groups of 7 bits, least significant
  /// group first.
  /// https://developers.google.com/protocol-buffers/docs/encoding
  ///
  /// value is the value being serialized
  /// Returns the byte array holding the serialized bits
  static Uint8List putUVarint(int value) {
    final buffer = <int>[];
    while (value >= 0x80) {
      buffer.add(((value & 0xFF) | 0x80));
      value >>= 7;
    }
    buffer.add(value & 0xFF);
    return Uint8List.fromList(buffer);
  }

  static IntConstBlock readIntConstBlock(Uint8List program, int pc) {
    final results = <int>[];
    var size = 1;
    var result = getUVarint(program, pc + size);
    if (result.length <= 0) {
      throw AlgorandException(
        message: 'could not decode int const block at pc=$pc',
      );
    }

    size += result.length;
    var numInts = result.value;
    for (var i = 0; i < numInts; i++) {
      if (pc + size >= program.length) {
        throw AlgorandException(
          message: 'int const block exceeds program length',
        );
      }
      result = getUVarint(program, pc + size);
      if (result.length <= 0) {
        throw AlgorandException(
          message: 'could not decode int const[$i] block at pc=${pc + size}',
        );
      }
      size += result.length;
      results.add(result.value);
    }

    return IntConstBlock(size, results);
  }

  static ByteConstBlock readByteConstBlock(Uint8List program, int pc) {
    final results = <Uint8List>[];
    var size = 1;
    var result = getUVarint(program, pc + size);
    if (result.length <= 0) {
      throw AlgorandException(
        message: 'could not decode byte[] const block at pc=$pc',
      );
    }

    size += result.length;
    var numInts = result.value;
    for (var i = 0; i < numInts; i++) {
      if (pc + size >= program.length) {
        throw AlgorandException(
          message: 'byte[] const block exceeds program length',
        );
      }
      result = getUVarint(program, pc + size);
      if (result.length <= 0) {
        throw AlgorandException(
          message: 'could not decode int const[$i] block at pc=${pc + size}',
        );
      }
      size += result.length;
      if (pc + size + result.value > program.length) {
        throw AlgorandException(
          message: '"byte[] const block exceeds program length',
        );
      }

      final buffer = List.filled(result.value, 0);
      buffer.setRange(0, result.value, program, pc + size);
      results.add(Uint8List.fromList(buffer));
      size += result.value;
    }

    return ByteConstBlock(size, results);
  }

  static IntConstBlock readPushIntOp(Uint8List program, int pc) {
    var size = 1;
    var result = getUVarint(program, pc + size);
    if (result.length <= 0) {
      throw AlgorandException(
        message: 'could not decode push int const at pc=$pc',
      );
    }

    size += result.length;

    return IntConstBlock(size, [result.value]);
  }

  static ByteConstBlock readPushByteOp(Uint8List program, int pc) {
    var size = 1;
    var result = getUVarint(program, pc + size);
    if (result.length <= 0) {
      throw AlgorandException(
        message: 'could not decode push byte const at pc=$pc',
      );
    }

    size += result.length;
    if (pc + size + result.value > program.length) {
      throw AlgorandException(
        message: '"byte[] const block exceeds program length',
      );
    }

    final buffer = List.filled(result.value, 0);
    buffer.setRange(0, result.value, program, pc + size);
    size += result.value;

    return ByteConstBlock(size, [Uint8List.fromList(buffer)]);
  }
}

class ProgramData {
  final bool good;
  final List<int> intBlock;
  final List<Uint8List> byteBlock;

  ProgramData({
    required this.good,
    required this.intBlock,
    required this.byteBlock,
  });
}

class VarintResult {
  final int value;
  final int length;

  VarintResult([this.value = 0, this.length = 0]);
}

class IntConstBlock {
  final int size;
  final List<int> results;

  IntConstBlock(this.size, this.results);
}

class ByteConstBlock {
  final int size;
  final List<Uint8List> results;

  ByteConstBlock(this.size, this.results);
}
