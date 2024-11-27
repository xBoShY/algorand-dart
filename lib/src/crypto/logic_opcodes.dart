import 'dart:typed_data';

import 'package:algorand_dart/algorand_dart.dart';

class LogicOpcodes {
  static (IntConstBlock?, ByteConstBlock?) intcblock_size(
    Uint8List program,
    int pc,
  ) {
    final intsBlock = Logic.readIntConstBlock(program, pc);
    return (intsBlock, null);
  }

  static (IntConstBlock?, ByteConstBlock?) bytecblock_size(
    Uint8List program,
    int pc,
  ) {
    final bytesBlock = Logic.readByteConstBlock(program, pc);
    return (null, bytesBlock);
  }

  static (IntConstBlock?, ByteConstBlock?) pushint_size(
    Uint8List program,
    int pc,
  ) {
    final pushInt = Logic.readPushIntOp(program, pc);
    return (pushInt, null);
  }

  static (IntConstBlock?, ByteConstBlock?) pushbytes_size(
    Uint8List program,
    int pc,
  ) {
    final pushBytes = Logic.readPushByteOp(program, pc);
    return (null, pushBytes);
  }

  static (IntConstBlock?, ByteConstBlock?) pushbytess_size(
    Uint8List program,
    int pc,
  ) {
    throw AlgorandException(message: 'OpCode not implemented');
  }

  static (IntConstBlock?, ByteConstBlock?) pushints_size(
    Uint8List program,
    int pc,
  ) {
    throw AlgorandException(message: 'OpCode not implemented');
  }

  static (IntConstBlock?, ByteConstBlock?) switch_size(
    Uint8List program,
    int pc,
  ) {
    throw AlgorandException(message: 'OpCode not implemented');
  }

  static (IntConstBlock?, ByteConstBlock?) match_size(
    Uint8List program,
    int pc,
  ) {
    throw AlgorandException(message: 'OpCode not implemented');
  }
}
