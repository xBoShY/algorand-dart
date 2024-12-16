const LANG_SPEC = r'''{
  "Version": 10,
  "LogicSigVersion": 10,
  "NamedTypes": [
    {
      "Name": "[]byte",
      "Abbreviation": "b",
      "Bound": [
        0,
        4096
      ],
      "AVMType": "[]byte"
    },
    {
      "Name": "address",
      "Abbreviation": "A",
      "Bound": [
        32,
        32
      ],
      "AVMType": "[]byte"
    },
    {
      "Name": "any",
      "Abbreviation": "a",
      "Bound": [
        0,
        0
      ],
      "AVMType": "any"
    },
    {
      "Name": "bigint",
      "Abbreviation": "I",
      "Bound": [
        0,
        64
      ],
      "AVMType": "[]byte"
    },
    {
      "Name": "bool",
      "Abbreviation": "T",
      "Bound": [
        0,
        1
      ],
      "AVMType": "uint64"
    },
    {
      "Name": "boxName",
      "Abbreviation": "N",
      "Bound": [
        1,
        64
      ],
      "AVMType": "[]byte"
    },
    {
      "Name": "method",
      "Abbreviation": "M",
      "Bound": [
        4,
        4
      ],
      "AVMType": "[]byte"
    },
    {
      "Name": "none",
      "Abbreviation": "x",
      "Bound": [
        0,
        0
      ],
      "AVMType": "none"
    },
    {
      "Name": "stateKey",
      "Abbreviation": "K",
      "Bound": [
        0,
        64
      ],
      "AVMType": "[]byte"
    },
    {
      "Name": "uint64",
      "Abbreviation": "i",
      "Bound": [
        0,
        18446744073709551615
      ],
      "AVMType": "uint64"
    }
  ],
  "Ops": [
    {
      "Opcode": 0,
      "Name": "err",
      "Size": 1,
      "DocCost": "1",
      "Doc": "Fail immediately.",
      "IntroducedVersion": 1,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 1,
      "Name": "sha256",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "[32]byte"
      ],
      "Size": 1,
      "DocCost": "35",
      "Doc": "SHA256 hash of value A, yields [32]byte",
      "IntroducedVersion": 1,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 2,
      "Name": "keccak256",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "[32]byte"
      ],
      "Size": 1,
      "DocCost": "130",
      "Doc": "Keccak256 hash of value A, yields [32]byte",
      "IntroducedVersion": 1,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 3,
      "Name": "sha512_256",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "[32]byte"
      ],
      "Size": 1,
      "DocCost": "45",
      "Doc": "SHA512_256 hash of value A, yields [32]byte",
      "IntroducedVersion": 1,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 4,
      "Name": "ed25519verify",
      "Args": [
        "[]byte",
        "[64]byte",
        "[32]byte"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1900",
      "Doc": "for (data A, signature B, pubkey C) verify the signature of (\"ProgData\" || program_hash || data) against the pubkey =\u003e {0 or 1}",
      "DocExtra": "The 32 byte public key is the last element on the stack, preceded by the 64 byte signature at the second-to-last element on the stack, preceded by the data which was signed at the third-to-last element on the stack.",
      "IntroducedVersion": 1,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 5,
      "Name": "ecdsa_verify",
      "Args": [
        "[32]byte",
        "[32]byte",
        "[32]byte",
        "[32]byte",
        "[32]byte"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 2,
      "ArgEnum": [
        "Secp256k1",
        "Secp256r1"
      ],
      "DocCost": "Secp256k1=1700; Secp256r1=2500",
      "Doc": "for (data A, signature B, C and pubkey D, E) verify the signature of the data against the pubkey =\u003e {0 or 1}",
      "DocExtra": "The 32 byte Y-component of a public key is the last element on the stack, preceded by X-component of a pubkey, preceded by S and R components of a signature, preceded by the data that is fifth element on the stack. All values are big-endian encoded. The signed data must be 32 bytes long, and signatures in lower-S form are only accepted.",
      "ImmediateNote": [
        {
          "Comment": "curve index",
          "Encoding": "uint8",
          "Name": "V",
          "Reference": "ECDSA"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 6,
      "Name": "ecdsa_pk_decompress",
      "Args": [
        "[33]byte"
      ],
      "Returns": [
        "[32]byte",
        "[32]byte"
      ],
      "Size": 2,
      "ArgEnum": [
        "Secp256k1",
        "Secp256r1"
      ],
      "DocCost": "Secp256k1=650; Secp256r1=2400",
      "Doc": "decompress pubkey A into components X, Y",
      "DocExtra": "The 33 byte public key in a compressed form to be decompressed into X and Y (top) components. All values are big-endian encoded.",
      "ImmediateNote": [
        {
          "Comment": "curve index",
          "Encoding": "uint8",
          "Name": "V",
          "Reference": "ECDSA"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 7,
      "Name": "ecdsa_pk_recover",
      "Args": [
        "[32]byte",
        "uint64",
        "[32]byte",
        "[32]byte"
      ],
      "Returns": [
        "[32]byte",
        "[32]byte"
      ],
      "Size": 2,
      "ArgEnum": [
        "Secp256k1",
        "Secp256r1"
      ],
      "DocCost": "2000",
      "Doc": "for (data A, recovery id B, signature C, D) recover a public key",
      "DocExtra": "S (top) and R elements of a signature, recovery id and data (bottom) are expected on the stack and used to deriver a public key. All values are big-endian encoded. The signed data must be 32 bytes long.",
      "ImmediateNote": [
        {
          "Comment": "curve index",
          "Encoding": "uint8",
          "Name": "V",
          "Reference": "ECDSA"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 8,
      "Name": "+",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A plus B. Fail on overflow.",
      "DocExtra": "Overflow is an error condition which halts execution and fails the transaction. Full precision is available from `addw`.",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 9,
      "Name": "-",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A minus B. Fail if B \u003e A.",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 10,
      "Name": "/",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A divided by B (truncated division). Fail if B == 0.",
      "DocExtra": "`divmodw` is available to divide the two-element values produced by `mulw` and `addw`.",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 11,
      "Name": "*",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A times B. Fail on overflow.",
      "DocExtra": "Overflow is an error condition which halts execution and fails the transaction. Full precision is available from `mulw`.",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 12,
      "Name": "\u003c",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A less than B =\u003e {0 or 1}",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 13,
      "Name": "\u003e",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A greater than B =\u003e {0 or 1}",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 14,
      "Name": "\u003c=",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A less than or equal to B =\u003e {0 or 1}",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 15,
      "Name": "\u003e=",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A greater than or equal to B =\u003e {0 or 1}",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 16,
      "Name": "\u0026\u0026",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A is not zero and B is not zero =\u003e {0 or 1}",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 17,
      "Name": "||",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A is not zero or B is not zero =\u003e {0 or 1}",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 18,
      "Name": "==",
      "Args": [
        "any",
        "any"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A is equal to B =\u003e {0 or 1}",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 19,
      "Name": "!=",
      "Args": [
        "any",
        "any"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A is not equal to B =\u003e {0 or 1}",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 20,
      "Name": "!",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A == 0 yields 1; else 0",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 21,
      "Name": "len",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "yields length of byte value A",
      "IntroducedVersion": 1,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 22,
      "Name": "itob",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "[8]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "converts uint64 A to big-endian byte array, always of length 8",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 23,
      "Name": "btoi",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "converts big-endian byte array A to uint64. Fails if len(A) \u003e 8. Padded by leading 0s if len(A) \u003c 8.",
      "DocExtra": "`btoi` fails if the input is longer than 8 bytes.",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 24,
      "Name": "%",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A modulo B. Fail if B == 0.",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 25,
      "Name": "|",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A bitwise-or B",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 26,
      "Name": "\u0026",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A bitwise-and B",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 27,
      "Name": "^",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A bitwise-xor B",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 28,
      "Name": "~",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "bitwise invert value A",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 29,
      "Name": "mulw",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64",
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A times B as a 128-bit result in two uint64s. X is the high 64 bits, Y is the low",
      "IntroducedVersion": 1,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 30,
      "Name": "addw",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64",
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A plus B as a 128-bit result. X is the carry-bit, Y is the low-order 64 bits.",
      "IntroducedVersion": 2,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 31,
      "Name": "divmodw",
      "Args": [
        "uint64",
        "uint64",
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64",
        "uint64",
        "uint64",
        "uint64"
      ],
      "Size": 1,
      "DocCost": "20",
      "Doc": "W,X = (A,B / C,D); Y,Z = (A,B modulo C,D)",
      "DocExtra": "The notation J,K indicates that two uint64 values J and K are interpreted as a uint128 value, with J as the high uint64 and K the low.",
      "IntroducedVersion": 4,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 32,
      "Name": "intcblock",
      "Size": 0,
      "DocCost": "1",
      "Doc": "prepare block of uint64 constants for use by intc",
      "DocExtra": "`intcblock` loads following program bytes into an array of integer constants in the evaluator. These integer constants can be referred to by `intc` and `intc_*` which will push the value onto the stack. Subsequent calls to `intcblock` reset and replace the integer constants available to the script.",
      "ImmediateNote": [
        {
          "Comment": "a block of int constant values",
          "Encoding": "varuint count, [varuint ...]",
          "Name": "UINT ..."
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 33,
      "Name": "intc",
      "Returns": [
        "uint64"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "Ith constant from intcblock",
      "ImmediateNote": [
        {
          "Comment": "an index in the intcblock",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 34,
      "Name": "intc_0",
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "constant 0 from intcblock",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 35,
      "Name": "intc_1",
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "constant 1 from intcblock",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 36,
      "Name": "intc_2",
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "constant 2 from intcblock",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 37,
      "Name": "intc_3",
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "constant 3 from intcblock",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 38,
      "Name": "bytecblock",
      "Size": 0,
      "DocCost": "1",
      "Doc": "prepare block of byte-array constants for use by bytec",
      "DocExtra": "`bytecblock` loads the following program bytes into an array of byte-array constants in the evaluator. These constants can be referred to by `bytec` and `bytec_*` which will push the value onto the stack. Subsequent calls to `bytecblock` reset and replace the bytes constants available to the script.",
      "ImmediateNote": [
        {
          "Comment": "a block of byte constant values",
          "Encoding": "varuint count, [varuint length, bytes ...]",
          "Name": "BYTES ..."
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 39,
      "Name": "bytec",
      "Returns": [
        "[]byte"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "Ith constant from bytecblock",
      "ImmediateNote": [
        {
          "Comment": "an index in the bytecblock",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 40,
      "Name": "bytec_0",
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "constant 0 from bytecblock",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 41,
      "Name": "bytec_1",
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "constant 1 from bytecblock",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 42,
      "Name": "bytec_2",
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "constant 2 from bytecblock",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 43,
      "Name": "bytec_3",
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "constant 3 from bytecblock",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 44,
      "Name": "arg",
      "Returns": [
        "[]byte"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "Nth LogicSig argument",
      "ImmediateNote": [
        {
          "Comment": "an arg index",
          "Encoding": "uint8",
          "Name": "N"
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 45,
      "Name": "arg_0",
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "LogicSig argument 0",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 46,
      "Name": "arg_1",
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "LogicSig argument 1",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 47,
      "Name": "arg_2",
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "LogicSig argument 2",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 48,
      "Name": "arg_3",
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "LogicSig argument 3",
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 49,
      "Name": "txn",
      "Returns": [
        "any"
      ],
      "Size": 2,
      "ArgEnum": [
        "Sender",
        "Fee",
        "FirstValid",
        "FirstValidTime",
        "LastValid",
        "Note",
        "Lease",
        "Receiver",
        "Amount",
        "CloseRemainderTo",
        "VotePK",
        "SelectionPK",
        "VoteFirst",
        "VoteLast",
        "VoteKeyDilution",
        "Type",
        "TypeEnum",
        "XferAsset",
        "AssetAmount",
        "AssetSender",
        "AssetReceiver",
        "AssetCloseTo",
        "GroupIndex",
        "TxID",
        "ApplicationID",
        "OnCompletion",
        "ApplicationArgs",
        "NumAppArgs",
        "Accounts",
        "NumAccounts",
        "ApprovalProgram",
        "ClearStateProgram",
        "RekeyTo",
        "ConfigAsset",
        "ConfigAssetTotal",
        "ConfigAssetDecimals",
        "ConfigAssetDefaultFrozen",
        "ConfigAssetUnitName",
        "ConfigAssetName",
        "ConfigAssetURL",
        "ConfigAssetMetadataHash",
        "ConfigAssetManager",
        "ConfigAssetReserve",
        "ConfigAssetFreeze",
        "ConfigAssetClawback",
        "FreezeAsset",
        "FreezeAssetAccount",
        "FreezeAssetFrozen",
        "Assets",
        "NumAssets",
        "Applications",
        "NumApplications",
        "GlobalNumUint",
        "GlobalNumByteSlice",
        "LocalNumUint",
        "LocalNumByteSlice",
        "ExtraProgramPages",
        "Nonparticipation",
        "Logs",
        "NumLogs",
        "CreatedAssetID",
        "CreatedApplicationID",
        "LastLog",
        "StateProofPK",
        "ApprovalProgramPages",
        "NumApprovalProgramPages",
        "ClearStateProgramPages",
        "NumClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "address",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[32]byte",
        "address",
        "uint64",
        "address",
        "[32]byte",
        "[32]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "address",
        "address",
        "address",
        "uint64",
        "[32]byte",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "address",
        "uint64",
        "[]byte",
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "[]byte",
        "[]byte",
        "[32]byte",
        "address",
        "address",
        "address",
        "address",
        "uint64",
        "address",
        "bool",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte",
        "uint64",
        "[]byte",
        "uint64"
      ],
      "DocCost": "1",
      "Doc": "field F of current transaction",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txn"
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 50,
      "Name": "global",
      "Returns": [
        "any"
      ],
      "Size": 2,
      "ArgEnum": [
        "MinTxnFee",
        "MinBalance",
        "MaxTxnLife",
        "ZeroAddress",
        "GroupSize",
        "LogicSigVersion",
        "Round",
        "LatestTimestamp",
        "CurrentApplicationID",
        "CreatorAddress",
        "CurrentApplicationAddress",
        "GroupID",
        "OpcodeBudget",
        "CallerApplicationID",
        "CallerApplicationAddress",
        "AssetCreateMinBalance",
        "AssetOptInMinBalance",
        "GenesisHash"
      ],
      "ArgEnumTypes": [
        "uint64",
        "uint64",
        "uint64",
        "address",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "address",
        "address",
        "[32]byte",
        "uint64",
        "uint64",
        "address",
        "uint64",
        "uint64",
        "[32]byte"
      ],
      "DocCost": "1",
      "Doc": "global field F",
      "ImmediateNote": [
        {
          "Comment": "a global field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "global"
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 51,
      "Name": "gtxn",
      "Returns": [
        "any"
      ],
      "Size": 3,
      "ArgEnum": [
        "Sender",
        "Fee",
        "FirstValid",
        "FirstValidTime",
        "LastValid",
        "Note",
        "Lease",
        "Receiver",
        "Amount",
        "CloseRemainderTo",
        "VotePK",
        "SelectionPK",
        "VoteFirst",
        "VoteLast",
        "VoteKeyDilution",
        "Type",
        "TypeEnum",
        "XferAsset",
        "AssetAmount",
        "AssetSender",
        "AssetReceiver",
        "AssetCloseTo",
        "GroupIndex",
        "TxID",
        "ApplicationID",
        "OnCompletion",
        "ApplicationArgs",
        "NumAppArgs",
        "Accounts",
        "NumAccounts",
        "ApprovalProgram",
        "ClearStateProgram",
        "RekeyTo",
        "ConfigAsset",
        "ConfigAssetTotal",
        "ConfigAssetDecimals",
        "ConfigAssetDefaultFrozen",
        "ConfigAssetUnitName",
        "ConfigAssetName",
        "ConfigAssetURL",
        "ConfigAssetMetadataHash",
        "ConfigAssetManager",
        "ConfigAssetReserve",
        "ConfigAssetFreeze",
        "ConfigAssetClawback",
        "FreezeAsset",
        "FreezeAssetAccount",
        "FreezeAssetFrozen",
        "Assets",
        "NumAssets",
        "Applications",
        "NumApplications",
        "GlobalNumUint",
        "GlobalNumByteSlice",
        "LocalNumUint",
        "LocalNumByteSlice",
        "ExtraProgramPages",
        "Nonparticipation",
        "Logs",
        "NumLogs",
        "CreatedAssetID",
        "CreatedApplicationID",
        "LastLog",
        "StateProofPK",
        "ApprovalProgramPages",
        "NumApprovalProgramPages",
        "ClearStateProgramPages",
        "NumClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "address",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[32]byte",
        "address",
        "uint64",
        "address",
        "[32]byte",
        "[32]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "address",
        "address",
        "address",
        "uint64",
        "[32]byte",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "address",
        "uint64",
        "[]byte",
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "[]byte",
        "[]byte",
        "[32]byte",
        "address",
        "address",
        "address",
        "address",
        "uint64",
        "address",
        "bool",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte",
        "uint64",
        "[]byte",
        "uint64"
      ],
      "DocCost": "1",
      "Doc": "field F of the Tth transaction in the current group",
      "DocExtra": "for notes on transaction fields available, see `txn`. If this transaction is _i_ in the group, `gtxn i field` is equivalent to `txn field`.",
      "ImmediateNote": [
        {
          "Comment": "transaction group index",
          "Encoding": "uint8",
          "Name": "T"
        },
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txn"
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 52,
      "Name": "load",
      "Returns": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "Ith scratch space value. All scratch spaces are 0 at program start.",
      "ImmediateNote": [
        {
          "Comment": "position in scratch space to load from",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 53,
      "Name": "store",
      "Args": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "store A to the Ith scratch space",
      "ImmediateNote": [
        {
          "Comment": "position in scratch space to store to",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 54,
      "Name": "txna",
      "Returns": [
        "any"
      ],
      "Size": 3,
      "ArgEnum": [
        "ApplicationArgs",
        "Accounts",
        "Assets",
        "Applications",
        "Logs",
        "ApprovalProgramPages",
        "ClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte"
      ],
      "DocCost": "1",
      "Doc": "Ith value of the array field F of the current transaction\n`txna` can be called using `txn` with 2 immediates.",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        },
        {
          "Comment": "transaction field array index",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 2,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 55,
      "Name": "gtxna",
      "Returns": [
        "any"
      ],
      "Size": 4,
      "ArgEnum": [
        "ApplicationArgs",
        "Accounts",
        "Assets",
        "Applications",
        "Logs",
        "ApprovalProgramPages",
        "ClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte"
      ],
      "DocCost": "1",
      "Doc": "Ith value of the array field F from the Tth transaction in the current group\n`gtxna` can be called using `gtxn` with 3 immediates.",
      "ImmediateNote": [
        {
          "Comment": "transaction group index",
          "Encoding": "uint8",
          "Name": "T"
        },
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        },
        {
          "Comment": "transaction field array index",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 2,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 56,
      "Name": "gtxns",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 2,
      "ArgEnum": [
        "Sender",
        "Fee",
        "FirstValid",
        "FirstValidTime",
        "LastValid",
        "Note",
        "Lease",
        "Receiver",
        "Amount",
        "CloseRemainderTo",
        "VotePK",
        "SelectionPK",
        "VoteFirst",
        "VoteLast",
        "VoteKeyDilution",
        "Type",
        "TypeEnum",
        "XferAsset",
        "AssetAmount",
        "AssetSender",
        "AssetReceiver",
        "AssetCloseTo",
        "GroupIndex",
        "TxID",
        "ApplicationID",
        "OnCompletion",
        "ApplicationArgs",
        "NumAppArgs",
        "Accounts",
        "NumAccounts",
        "ApprovalProgram",
        "ClearStateProgram",
        "RekeyTo",
        "ConfigAsset",
        "ConfigAssetTotal",
        "ConfigAssetDecimals",
        "ConfigAssetDefaultFrozen",
        "ConfigAssetUnitName",
        "ConfigAssetName",
        "ConfigAssetURL",
        "ConfigAssetMetadataHash",
        "ConfigAssetManager",
        "ConfigAssetReserve",
        "ConfigAssetFreeze",
        "ConfigAssetClawback",
        "FreezeAsset",
        "FreezeAssetAccount",
        "FreezeAssetFrozen",
        "Assets",
        "NumAssets",
        "Applications",
        "NumApplications",
        "GlobalNumUint",
        "GlobalNumByteSlice",
        "LocalNumUint",
        "LocalNumByteSlice",
        "ExtraProgramPages",
        "Nonparticipation",
        "Logs",
        "NumLogs",
        "CreatedAssetID",
        "CreatedApplicationID",
        "LastLog",
        "StateProofPK",
        "ApprovalProgramPages",
        "NumApprovalProgramPages",
        "ClearStateProgramPages",
        "NumClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "address",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[32]byte",
        "address",
        "uint64",
        "address",
        "[32]byte",
        "[32]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "address",
        "address",
        "address",
        "uint64",
        "[32]byte",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "address",
        "uint64",
        "[]byte",
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "[]byte",
        "[]byte",
        "[32]byte",
        "address",
        "address",
        "address",
        "address",
        "uint64",
        "address",
        "bool",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte",
        "uint64",
        "[]byte",
        "uint64"
      ],
      "DocCost": "1",
      "Doc": "field F of the Ath transaction in the current group",
      "DocExtra": "for notes on transaction fields available, see `txn`. If top of stack is _i_, `gtxns field` is equivalent to `gtxn _i_ field`. gtxns exists so that _i_ can be calculated, often based on the index of the current transaction.",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txn"
        }
      ],
      "IntroducedVersion": 3,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 57,
      "Name": "gtxnsa",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 3,
      "ArgEnum": [
        "ApplicationArgs",
        "Accounts",
        "Assets",
        "Applications",
        "Logs",
        "ApprovalProgramPages",
        "ClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte"
      ],
      "DocCost": "1",
      "Doc": "Ith value of the array field F from the Ath transaction in the current group\n`gtxnsa` can be called using `gtxns` with 2 immediates.",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        },
        {
          "Comment": "transaction field array index",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 3,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 58,
      "Name": "gload",
      "Returns": [
        "any"
      ],
      "Size": 3,
      "DocCost": "1",
      "Doc": "Ith scratch space value of the Tth transaction in the current group",
      "DocExtra": "`gload` fails unless the requested transaction is an ApplicationCall and T \u003c GroupIndex.",
      "ImmediateNote": [
        {
          "Comment": "transaction group index",
          "Encoding": "uint8",
          "Name": "T"
        },
        {
          "Comment": "position in scratch space to load from",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 4,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 59,
      "Name": "gloads",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "Ith scratch space value of the Ath transaction in the current group",
      "DocExtra": "`gloads` fails unless the requested transaction is an ApplicationCall and A \u003c GroupIndex.",
      "ImmediateNote": [
        {
          "Comment": "position in scratch space to load from",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 4,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 60,
      "Name": "gaid",
      "Returns": [
        "uint64"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "ID of the asset or application created in the Tth transaction of the current group",
      "DocExtra": "`gaid` fails unless the requested transaction created an asset or application and T \u003c GroupIndex.",
      "ImmediateNote": [
        {
          "Comment": "transaction group index",
          "Encoding": "uint8",
          "Name": "T"
        }
      ],
      "IntroducedVersion": 4,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 61,
      "Name": "gaids",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "ID of the asset or application created in the Ath transaction of the current group",
      "DocExtra": "`gaids` fails unless the requested transaction created an asset or application and A \u003c GroupIndex.",
      "IntroducedVersion": 4,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 62,
      "Name": "loads",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "Ath scratch space value.  All scratch spaces are 0 at program start.",
      "IntroducedVersion": 5,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 63,
      "Name": "stores",
      "Args": [
        "uint64",
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "store B to the Ath scratch space",
      "IntroducedVersion": 5,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 64,
      "Name": "bnz",
      "Args": [
        "uint64"
      ],
      "Size": 3,
      "DocCost": "1",
      "Doc": "branch to TARGET if value A is not zero",
      "DocExtra": "The `bnz` instruction opcode 0x40 is followed by two immediate data bytes which are a high byte first and low byte second which together form a 16 bit offset which the instruction may branch to. For a bnz instruction at `pc`, if the last element of the stack is not zero then branch to instruction at `pc + 3 + N`, else proceed to next instruction at `pc + 3`. Branch targets must be aligned instructions. (e.g. Branching to the second byte of a 2 byte op will be rejected.) Starting at v4, the offset is treated as a signed 16 bit integer allowing for backward branches and looping. In prior version (v1 to v3), branch offsets are limited to forward branches only, 0-0x7fff.\n\nAt v2 it became allowed to branch to the end of the program exactly after the last instruction: bnz to byte N (with 0-indexing) was illegal for a TEAL program with N bytes before v2, and is legal after it. This change eliminates the need for a last instruction of no-op as a branch target at the end. (Branching beyond the end--in other words, to a byte larger than N--is still illegal and will cause the program to fail.)",
      "ImmediateNote": [
        {
          "Comment": "branch offset",
          "Encoding": "int16 (big-endian)",
          "Name": "TARGET"
        }
      ],
      "IntroducedVersion": 1,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 65,
      "Name": "bz",
      "Args": [
        "uint64"
      ],
      "Size": 3,
      "DocCost": "1",
      "Doc": "branch to TARGET if value A is zero",
      "DocExtra": "See `bnz` for details on how branches work. `bz` inverts the behavior of `bnz`.",
      "ImmediateNote": [
        {
          "Comment": "branch offset",
          "Encoding": "int16 (big-endian)",
          "Name": "TARGET"
        }
      ],
      "IntroducedVersion": 2,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 66,
      "Name": "b",
      "Size": 3,
      "DocCost": "1",
      "Doc": "branch unconditionally to TARGET",
      "DocExtra": "See `bnz` for details on how branches work. `b` always jumps to the offset.",
      "ImmediateNote": [
        {
          "Comment": "branch offset",
          "Encoding": "int16 (big-endian)",
          "Name": "TARGET"
        }
      ],
      "IntroducedVersion": 2,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 67,
      "Name": "return",
      "Args": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "use A as success value; end",
      "IntroducedVersion": 2,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 68,
      "Name": "assert",
      "Args": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "immediately fail unless A is a non-zero number",
      "IntroducedVersion": 3,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 69,
      "Name": "bury",
      "Args": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "replace the Nth value from the top of the stack with A. bury 0 fails.",
      "ImmediateNote": [
        {
          "Comment": "depth",
          "Encoding": "uint8",
          "Name": "N"
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 70,
      "Name": "popn",
      "Size": 2,
      "DocCost": "1",
      "Doc": "remove N values from the top of the stack",
      "ImmediateNote": [
        {
          "Comment": "stack depth",
          "Encoding": "uint8",
          "Name": "N"
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 71,
      "Name": "dupn",
      "Args": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "duplicate A, N times",
      "ImmediateNote": [
        {
          "Comment": "copy count",
          "Encoding": "uint8",
          "Name": "N"
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 72,
      "Name": "pop",
      "Args": [
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "discard A",
      "IntroducedVersion": 1,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 73,
      "Name": "dup",
      "Args": [
        "any"
      ],
      "Returns": [
        "any",
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "duplicate A",
      "IntroducedVersion": 1,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 74,
      "Name": "dup2",
      "Args": [
        "any",
        "any"
      ],
      "Returns": [
        "any",
        "any",
        "any",
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "duplicate A and B",
      "IntroducedVersion": 2,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 75,
      "Name": "dig",
      "Args": [
        "any"
      ],
      "Returns": [
        "any",
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "Nth value from the top of the stack. dig 0 is equivalent to dup",
      "ImmediateNote": [
        {
          "Comment": "depth",
          "Encoding": "uint8",
          "Name": "N"
        }
      ],
      "IntroducedVersion": 3,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 76,
      "Name": "swap",
      "Args": [
        "any",
        "any"
      ],
      "Returns": [
        "any",
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "swaps A and B on stack",
      "IntroducedVersion": 3,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 77,
      "Name": "select",
      "Args": [
        "any",
        "any",
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "selects one of two values based on top-of-stack: B if C != 0, else A",
      "IntroducedVersion": 3,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 78,
      "Name": "cover",
      "Args": [
        "any"
      ],
      "Returns": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "remove top of stack, and place it deeper in the stack such that N elements are above it. Fails if stack depth \u003c= N.",
      "ImmediateNote": [
        {
          "Comment": "depth",
          "Encoding": "uint8",
          "Name": "N"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 79,
      "Name": "uncover",
      "Args": [
        "any"
      ],
      "Returns": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "remove the value at depth N in the stack and shift above items down so the Nth deep value is on top of the stack. Fails if stack depth \u003c= N.",
      "ImmediateNote": [
        {
          "Comment": "depth",
          "Encoding": "uint8",
          "Name": "N"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 80,
      "Name": "concat",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "join A and B",
      "DocExtra": "`concat` fails if the result would be greater than 4096 bytes.",
      "IntroducedVersion": 2,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 81,
      "Name": "substring",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 3,
      "DocCost": "1",
      "Doc": "A range of bytes from A starting at S up to but not including E. If E \u003c S, or either is larger than the array length, the program fails",
      "ImmediateNote": [
        {
          "Comment": "start position",
          "Encoding": "uint8",
          "Name": "S"
        },
        {
          "Comment": "end position",
          "Encoding": "uint8",
          "Name": "E"
        }
      ],
      "IntroducedVersion": 2,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 82,
      "Name": "substring3",
      "Args": [
        "[]byte",
        "uint64",
        "uint64"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A range of bytes from A starting at B up to but not including C. If C \u003c B, or either is larger than the array length, the program fails",
      "IntroducedVersion": 2,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 83,
      "Name": "getbit",
      "Args": [
        "any",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "Bth bit of (byte-array or integer) A. If B is greater than or equal to the bit length of the value (8*byte length), the program fails",
      "DocExtra": "see explanation of bit ordering in setbit",
      "IntroducedVersion": 3,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 84,
      "Name": "setbit",
      "Args": [
        "any",
        "uint64",
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "Copy of (byte-array or integer) A, with the Bth bit set to (0 or 1) C. If B is greater than or equal to the bit length of the value (8*byte length), the program fails",
      "DocExtra": "When A is a uint64, index 0 is the least significant bit. Setting bit 3 to 1 on the integer 0 yields 8, or 2^3. When A is a byte array, index 0 is the leftmost bit of the leftmost byte. Setting bits 0 through 11 to 1 in a 4-byte-array of 0s yields the byte array 0xfff00000. Setting bit 3 to 1 on the 1-byte-array 0x00 yields the byte array 0x10.",
      "IntroducedVersion": 3,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 85,
      "Name": "getbyte",
      "Args": [
        "[]byte",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "Bth byte of A, as an integer. If B is greater than or equal to the array length, the program fails",
      "IntroducedVersion": 3,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 86,
      "Name": "setbyte",
      "Args": [
        "[]byte",
        "uint64",
        "uint64"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "Copy of A with the Bth byte set to small integer (between 0..255) C. If B is greater than or equal to the array length, the program fails",
      "IntroducedVersion": 3,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 87,
      "Name": "extract",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 3,
      "DocCost": "1",
      "Doc": "A range of bytes from A starting at S up to but not including S+L. If L is 0, then extract to the end of the string. If S or S+L is larger than the array length, the program fails",
      "ImmediateNote": [
        {
          "Comment": "start position",
          "Encoding": "uint8",
          "Name": "S"
        },
        {
          "Comment": "length",
          "Encoding": "uint8",
          "Name": "L"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 88,
      "Name": "extract3",
      "Args": [
        "[]byte",
        "uint64",
        "uint64"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A range of bytes from A starting at B up to but not including B+C. If B+C is larger than the array length, the program fails\n`extract3` can be called using `extract` with no immediates.",
      "IntroducedVersion": 5,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 89,
      "Name": "extract_uint16",
      "Args": [
        "[]byte",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A uint16 formed from a range of big-endian bytes from A starting at B up to but not including B+2. If B+2 is larger than the array length, the program fails",
      "IntroducedVersion": 5,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 90,
      "Name": "extract_uint32",
      "Args": [
        "[]byte",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A uint32 formed from a range of big-endian bytes from A starting at B up to but not including B+4. If B+4 is larger than the array length, the program fails",
      "IntroducedVersion": 5,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 91,
      "Name": "extract_uint64",
      "Args": [
        "[]byte",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A uint64 formed from a range of big-endian bytes from A starting at B up to but not including B+8. If B+8 is larger than the array length, the program fails",
      "IntroducedVersion": 5,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 92,
      "Name": "replace2",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "Copy of A with the bytes starting at S replaced by the bytes of B. Fails if S+len(B) exceeds len(A)\n`replace2` can be called using `replace` with 1 immediate.",
      "ImmediateNote": [
        {
          "Comment": "start position",
          "Encoding": "uint8",
          "Name": "S"
        }
      ],
      "IntroducedVersion": 7,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 93,
      "Name": "replace3",
      "Args": [
        "[]byte",
        "uint64",
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "Copy of A with the bytes starting at B replaced by the bytes of C. Fails if B+len(C) exceeds len(A)\n`replace3` can be called using `replace` with no immediates.",
      "IntroducedVersion": 7,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 94,
      "Name": "base64_decode",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 2,
      "ArgEnum": [
        "URLEncoding",
        "StdEncoding"
      ],
      "ArgEnumTypes": [
        "any",
        "any"
      ],
      "DocCost": "1 + 1 per 16 bytes of A",
      "Doc": "decode A which was base64-encoded using _encoding_ E. Fail if A is not base64 encoded with encoding E",
      "DocExtra": "*Warning*: Usage should be restricted to very rare use cases. In almost all cases, smart contracts should directly handle non-encoded byte-strings.\tThis opcode should only be used in cases where base64 is the only available option, e.g. interoperability with a third-party that only signs base64 strings.\n\n Decodes A using the base64 encoding E. Specify the encoding with an immediate arg either as URL and Filename Safe (`URLEncoding`) or Standard (`StdEncoding`). See [RFC 4648 sections 4 and 5](https://rfc-editor.org/rfc/rfc4648.html#section-4). It is assumed that the encoding ends with the exact number of `=` padding characters as required by the RFC. When padding occurs, any unused pad bits in the encoding must be set to zero or the decoding will fail. The special cases of `\\n` and `\\r` are allowed but completely ignored. An error will result when attempting to decode a string with a character that is not in the encoding alphabet or not one of `=`, `\\r`, or `\\n`.",
      "ImmediateNote": [
        {
          "Comment": "encoding index",
          "Encoding": "uint8",
          "Name": "E",
          "Reference": "base64"
        }
      ],
      "IntroducedVersion": 7,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 95,
      "Name": "json_ref",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "any"
      ],
      "Size": 2,
      "ArgEnum": [
        "JSONString",
        "JSONUint64",
        "JSONObject"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "uint64",
        "[]byte"
      ],
      "DocCost": "25 + 2 per 7 bytes of A",
      "Doc": "key B's value, of type R, from a [valid](jsonspec.md) utf-8 encoded json object A",
      "DocExtra": "*Warning*: Usage should be restricted to very rare use cases, as JSON decoding is expensive and quite limited. In addition, JSON objects are large and not optimized for size.\n\nAlmost all smart contracts should use simpler and smaller methods (such as the [ABI](https://arc.algorand.foundation/ARCs/arc-0004). This opcode should only be used in cases where JSON is only available option, e.g. when a third-party only signs JSON.",
      "ImmediateNote": [
        {
          "Comment": "return type index",
          "Encoding": "uint8",
          "Name": "R",
          "Reference": "json_ref"
        }
      ],
      "IntroducedVersion": 7,
      "Groups": [
        "Byte Array Manipulation"
      ]
    },
    {
      "Opcode": 96,
      "Name": "balance",
      "Args": [
        "any"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "balance for account A, in microalgos. The balance is observed after the effects of previous transactions in the group, and after the fee for the current transaction is deducted. Changes caused by inner transactions are observable immediately following `itxn_submit`",
      "DocExtra": "params: Txn.Accounts offset (or, since v4, an _available_ account address), _available_ application id (or, since v4, a Txn.ForeignApps offset). Return: value.",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 97,
      "Name": "app_opted_in",
      "Args": [
        "any",
        "uint64"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "1 if account A is opted in to application B, else 0",
      "DocExtra": "params: Txn.Accounts offset (or, since v4, an _available_ account address), _available_ application id (or, since v4, a Txn.ForeignApps offset). Return: 1 if opted in and 0 otherwise.",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 98,
      "Name": "app_local_get",
      "Args": [
        "any",
        "stateKey"
      ],
      "Returns": [
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "local state of the key B in the current application in account A",
      "DocExtra": "params: Txn.Accounts offset (or, since v4, an _available_ account address), state key. Return: value. The value is zero (of type uint64) if the key does not exist.",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 99,
      "Name": "app_local_get_ex",
      "Args": [
        "any",
        "uint64",
        "stateKey"
      ],
      "Returns": [
        "any",
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "X is the local state of application B, key C in account A. Y is 1 if key existed, else 0",
      "DocExtra": "params: Txn.Accounts offset (or, since v4, an _available_ account address), _available_ application id (or, since v4, a Txn.ForeignApps offset), state key. Return: did_exist flag (top of the stack, 1 if the application and key existed and 0 otherwise), value. The value is zero (of type uint64) if the key does not exist.",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 100,
      "Name": "app_global_get",
      "Args": [
        "stateKey"
      ],
      "Returns": [
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "global state of the key A in the current application",
      "DocExtra": "params: state key. Return: value. The value is zero (of type uint64) if the key does not exist.",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 101,
      "Name": "app_global_get_ex",
      "Args": [
        "uint64",
        "stateKey"
      ],
      "Returns": [
        "any",
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "X is the global state of application A, key B. Y is 1 if key existed, else 0",
      "DocExtra": "params: Txn.ForeignApps offset (or, since v4, an _available_ application id), state key. Return: did_exist flag (top of the stack, 1 if the application and key existed and 0 otherwise), value. The value is zero (of type uint64) if the key does not exist.",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 102,
      "Name": "app_local_put",
      "Args": [
        "any",
        "stateKey",
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "write C to key B in account A's local state of the current application",
      "DocExtra": "params: Txn.Accounts offset (or, since v4, an _available_ account address), state key, value.",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 103,
      "Name": "app_global_put",
      "Args": [
        "stateKey",
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "write B to key A in the global state of the current application",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 104,
      "Name": "app_local_del",
      "Args": [
        "any",
        "stateKey"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "delete key B from account A's local state of the current application",
      "DocExtra": "params: Txn.Accounts offset (or, since v4, an _available_ account address), state key.\n\nDeleting a key which is already absent has no effect on the application local state. (In particular, it does _not_ cause the program to fail.)",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 105,
      "Name": "app_global_del",
      "Args": [
        "stateKey"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "delete key A from the global state of the current application",
      "DocExtra": "params: state key.\n\nDeleting a key which is already absent has no effect on the application global state. (In particular, it does _not_ cause the program to fail.)",
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 112,
      "Name": "asset_holding_get",
      "Args": [
        "any",
        "uint64"
      ],
      "Returns": [
        "any",
        "bool"
      ],
      "Size": 2,
      "ArgEnum": [
        "AssetBalance",
        "AssetFrozen"
      ],
      "ArgEnumTypes": [
        "uint64",
        "bool"
      ],
      "DocCost": "1",
      "Doc": "X is field F from account A's holding of asset B. Y is 1 if A is opted into B, else 0",
      "DocExtra": "params: Txn.Accounts offset (or, since v4, an _available_ address), asset id (or, since v4, a Txn.ForeignAssets offset). Return: did_exist flag (1 if the asset existed and 0 otherwise), value.",
      "ImmediateNote": [
        {
          "Comment": "asset holding field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "asset_holding"
        }
      ],
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 113,
      "Name": "asset_params_get",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any",
        "bool"
      ],
      "Size": 2,
      "ArgEnum": [
        "AssetTotal",
        "AssetDecimals",
        "AssetDefaultFrozen",
        "AssetUnitName",
        "AssetName",
        "AssetURL",
        "AssetMetadataHash",
        "AssetManager",
        "AssetReserve",
        "AssetFreeze",
        "AssetClawback",
        "AssetCreator"
      ],
      "ArgEnumTypes": [
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "[]byte",
        "[]byte",
        "[32]byte",
        "address",
        "address",
        "address",
        "address",
        "address"
      ],
      "DocCost": "1",
      "Doc": "X is field F from asset A. Y is 1 if A exists, else 0",
      "DocExtra": "params: Txn.ForeignAssets offset (or, since v4, an _available_ asset id. Return: did_exist flag (1 if the asset existed and 0 otherwise), value.",
      "ImmediateNote": [
        {
          "Comment": "asset params field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "asset_params"
        }
      ],
      "IntroducedVersion": 2,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 114,
      "Name": "app_params_get",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any",
        "bool"
      ],
      "Size": 2,
      "ArgEnum": [
        "AppApprovalProgram",
        "AppClearStateProgram",
        "AppGlobalNumUint",
        "AppGlobalNumByteSlice",
        "AppLocalNumUint",
        "AppLocalNumByteSlice",
        "AppExtraProgramPages",
        "AppCreator",
        "AppAddress"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "address",
        "address"
      ],
      "DocCost": "1",
      "Doc": "X is field F from app A. Y is 1 if A exists, else 0",
      "DocExtra": "params: Txn.ForeignApps offset or an _available_ app id. Return: did_exist flag (1 if the application existed and 0 otherwise), value.",
      "ImmediateNote": [
        {
          "Comment": "app params field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "app_params"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 115,
      "Name": "acct_params_get",
      "Args": [
        "any"
      ],
      "Returns": [
        "any",
        "bool"
      ],
      "Size": 2,
      "ArgEnum": [
        "AcctBalance",
        "AcctMinBalance",
        "AcctAuthAddr",
        "AcctTotalNumUint",
        "AcctTotalNumByteSlice",
        "AcctTotalExtraAppPages",
        "AcctTotalAppsCreated",
        "AcctTotalAppsOptedIn",
        "AcctTotalAssetsCreated",
        "AcctTotalAssets",
        "AcctTotalBoxes",
        "AcctTotalBoxBytes"
      ],
      "ArgEnumTypes": [
        "uint64",
        "uint64",
        "address",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64"
      ],
      "DocCost": "1",
      "Doc": "X is field F from account A. Y is 1 if A owns positive algos, else 0",
      "ImmediateNote": [
        {
          "Comment": "account params field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "acct_params"
        }
      ],
      "IntroducedVersion": 6,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 120,
      "Name": "min_balance",
      "Args": [
        "any"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "minimum required balance for account A, in microalgos. Required balance is affected by ASA, App, and Box usage. When creating or opting into an app, the minimum balance grows before the app code runs, therefore the increase is visible there. When deleting or closing out, the minimum balance decreases after the app executes. Changes caused by inner transactions or box usage are observable immediately following the opcode effecting the change.",
      "DocExtra": "params: Txn.Accounts offset (or, since v4, an _available_ account address), _available_ application id (or, since v4, a Txn.ForeignApps offset). Return: value.",
      "IntroducedVersion": 3,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 128,
      "Name": "pushbytes",
      "Returns": [
        "[]byte"
      ],
      "Size": 0,
      "DocCost": "1",
      "Doc": "immediate BYTES",
      "DocExtra": "pushbytes args are not added to the bytecblock during assembly processes",
      "ImmediateNote": [
        {
          "Comment": "a byte constant",
          "Encoding": "varuint length, bytes",
          "Name": "BYTES"
        }
      ],
      "IntroducedVersion": 3,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 129,
      "Name": "pushint",
      "Returns": [
        "uint64"
      ],
      "Size": 0,
      "DocCost": "1",
      "Doc": "immediate UINT",
      "DocExtra": "pushint args are not added to the intcblock during assembly processes",
      "ImmediateNote": [
        {
          "Comment": "an int constant",
          "Encoding": "varuint",
          "Name": "UINT"
        }
      ],
      "IntroducedVersion": 3,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 130,
      "Name": "pushbytess",
      "Size": 0,
      "DocCost": "1",
      "Doc": "push sequences of immediate byte arrays to stack (first byte array being deepest)",
      "DocExtra": "pushbytess args are not added to the bytecblock during assembly processes",
      "ImmediateNote": [
        {
          "Comment": "a list of byte constants",
          "Encoding": "varuint count, [varuint length, bytes ...]",
          "Name": "BYTES ..."
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 131,
      "Name": "pushints",
      "Size": 0,
      "DocCost": "1",
      "Doc": "push sequence of immediate uints to stack in the order they appear (first uint being deepest)",
      "DocExtra": "pushints args are not added to the intcblock during assembly processes",
      "ImmediateNote": [
        {
          "Comment": "a list of int constants",
          "Encoding": "varuint count, [varuint ...]",
          "Name": "UINT ..."
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 132,
      "Name": "ed25519verify_bare",
      "Args": [
        "[]byte",
        "[64]byte",
        "[32]byte"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1900",
      "Doc": "for (data A, signature B, pubkey C) verify the signature of the data against the pubkey =\u003e {0 or 1}",
      "IntroducedVersion": 7,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 136,
      "Name": "callsub",
      "Size": 3,
      "DocCost": "1",
      "Doc": "branch unconditionally to TARGET, saving the next instruction on the call stack",
      "DocExtra": "The call stack is separate from the data stack. Only `callsub`, `retsub`, and `proto` manipulate it.",
      "ImmediateNote": [
        {
          "Comment": "branch offset",
          "Encoding": "int16 (big-endian)",
          "Name": "TARGET"
        }
      ],
      "IntroducedVersion": 4,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 137,
      "Name": "retsub",
      "Size": 1,
      "DocCost": "1",
      "Doc": "pop the top instruction from the call stack and branch to it",
      "DocExtra": "If the current frame was prepared by `proto A R`, `retsub` will remove the 'A' arguments from the stack, move the `R` return values down, and pop any stack locations above the relocated return values.",
      "IntroducedVersion": 4,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 138,
      "Name": "proto",
      "Size": 3,
      "DocCost": "1",
      "Doc": "Prepare top call frame for a retsub that will assume A args and R return values.",
      "DocExtra": "Fails unless the last instruction executed was a `callsub`.",
      "ImmediateNote": [
        {
          "Comment": "number of arguments",
          "Encoding": "uint8",
          "Name": "A"
        },
        {
          "Comment": "number of return values",
          "Encoding": "uint8",
          "Name": "R"
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 139,
      "Name": "frame_dig",
      "Returns": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "Nth (signed) value from the frame pointer.",
      "ImmediateNote": [
        {
          "Comment": "frame slot",
          "Encoding": "int8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 140,
      "Name": "frame_bury",
      "Args": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "replace the Nth (signed) value from the frame pointer in the stack with A",
      "ImmediateNote": [
        {
          "Comment": "frame slot",
          "Encoding": "int8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 141,
      "Name": "switch",
      "Args": [
        "uint64"
      ],
      "Size": 0,
      "DocCost": "1",
      "Doc": "branch to the Ath label. Continue at following instruction if index A exceeds the number of labels.",
      "ImmediateNote": [
        {
          "Comment": "list of labels",
          "Encoding": "varuint count, [int16 (big-endian) ...]",
          "Name": "TARGET ..."
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 142,
      "Name": "match",
      "Size": 0,
      "DocCost": "1",
      "Doc": "given match cases from A[1] to A[N], branch to the Ith label where A[I] = B. Continue to the following instruction if no matches are found.",
      "DocExtra": "`match` consumes N+1 values from the stack. Let the top stack value be B. The following N values represent an ordered list of match cases/constants (A), where the first value (A[0]) is the deepest in the stack. The immediate arguments are an ordered list of N labels (T). `match` will branch to target T[I], where A[I] = B. If there are no matches then execution continues on to the next instruction.",
      "ImmediateNote": [
        {
          "Comment": "list of labels",
          "Encoding": "varuint count, [int16 (big-endian) ...]",
          "Name": "TARGET ..."
        }
      ],
      "IntroducedVersion": 8,
      "Groups": [
        "Flow Control"
      ]
    },
    {
      "Opcode": 144,
      "Name": "shl",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A times 2^B, modulo 2^64",
      "IntroducedVersion": 4,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 145,
      "Name": "shr",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A divided by 2^B",
      "IntroducedVersion": 4,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 146,
      "Name": "sqrt",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "4",
      "Doc": "The largest integer I such that I^2 \u003c= A",
      "IntroducedVersion": 4,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 147,
      "Name": "bitlen",
      "Args": [
        "any"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "The highest set bit in A. If A is a byte-array, it is interpreted as a big-endian unsigned integer. bitlen of 0 is 0, bitlen of 8 is 4",
      "DocExtra": "bitlen interprets arrays as big-endian integers, unlike setbit/getbit",
      "IntroducedVersion": 4,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 148,
      "Name": "exp",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A raised to the Bth power. Fail if A == B == 0 and on overflow",
      "IntroducedVersion": 4,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 149,
      "Name": "expw",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64",
        "uint64"
      ],
      "Size": 1,
      "DocCost": "10",
      "Doc": "A raised to the Bth power as a 128-bit result in two uint64s. X is the high 64 bits, Y is the low. Fail if A == B == 0 or if the results exceeds 2^128-1",
      "IntroducedVersion": 4,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 150,
      "Name": "bsqrt",
      "Args": [
        "bigint"
      ],
      "Returns": [
        "bigint"
      ],
      "Size": 1,
      "DocCost": "40",
      "Doc": "The largest integer I such that I^2 \u003c= A. A and I are interpreted as big-endian unsigned integers",
      "IntroducedVersion": 6,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 151,
      "Name": "divw",
      "Args": [
        "uint64",
        "uint64",
        "uint64"
      ],
      "Returns": [
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "A,B / C. Fail if C == 0 or if result overflows.",
      "DocExtra": "The notation A,B indicates that A and B are interpreted as a uint128 value, with A as the high uint64 and B the low.",
      "IntroducedVersion": 6,
      "Groups": [
        "Arithmetic"
      ]
    },
    {
      "Opcode": 152,
      "Name": "sha3_256",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "[32]byte"
      ],
      "Size": 1,
      "DocCost": "130",
      "Doc": "SHA3_256 hash of value A, yields [32]byte",
      "IntroducedVersion": 7,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 160,
      "Name": "b+",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "10",
      "Doc": "A plus B. A and B are interpreted as big-endian unsigned integers",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 161,
      "Name": "b-",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "bigint"
      ],
      "Size": 1,
      "DocCost": "10",
      "Doc": "A minus B. A and B are interpreted as big-endian unsigned integers. Fail on underflow.",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 162,
      "Name": "b/",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "bigint"
      ],
      "Size": 1,
      "DocCost": "20",
      "Doc": "A divided by B (truncated division). A and B are interpreted as big-endian unsigned integers. Fail if B is zero.",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 163,
      "Name": "b*",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "20",
      "Doc": "A times B. A and B are interpreted as big-endian unsigned integers.",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 164,
      "Name": "b\u003c",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "1 if A is less than B, else 0. A and B are interpreted as big-endian unsigned integers",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 165,
      "Name": "b\u003e",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "1 if A is greater than B, else 0. A and B are interpreted as big-endian unsigned integers",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 166,
      "Name": "b\u003c=",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "1 if A is less than or equal to B, else 0. A and B are interpreted as big-endian unsigned integers",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 167,
      "Name": "b\u003e=",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "1 if A is greater than or equal to B, else 0. A and B are interpreted as big-endian unsigned integers",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 168,
      "Name": "b==",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "1 if A is equal to B, else 0. A and B are interpreted as big-endian unsigned integers",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 169,
      "Name": "b!=",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "0 if A is equal to B, else 1. A and B are interpreted as big-endian unsigned integers",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 170,
      "Name": "b%",
      "Args": [
        "bigint",
        "bigint"
      ],
      "Returns": [
        "bigint"
      ],
      "Size": 1,
      "DocCost": "20",
      "Doc": "A modulo B. A and B are interpreted as big-endian unsigned integers. Fail if B is zero.",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Arithmetic"
      ]
    },
    {
      "Opcode": 171,
      "Name": "b|",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "6",
      "Doc": "A bitwise-or B. A and B are zero-left extended to the greater of their lengths",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Logic"
      ]
    },
    {
      "Opcode": 172,
      "Name": "b\u0026",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "6",
      "Doc": "A bitwise-and B. A and B are zero-left extended to the greater of their lengths",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Logic"
      ]
    },
    {
      "Opcode": 173,
      "Name": "b^",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "6",
      "Doc": "A bitwise-xor B. A and B are zero-left extended to the greater of their lengths",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Logic"
      ]
    },
    {
      "Opcode": 174,
      "Name": "b~",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "4",
      "Doc": "A with all bits inverted",
      "IntroducedVersion": 4,
      "Groups": [
        "Byte Array Logic"
      ]
    },
    {
      "Opcode": 175,
      "Name": "bzero",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "zero filled byte-array of length A",
      "IntroducedVersion": 4,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 176,
      "Name": "log",
      "Args": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "write A to log state of the current application",
      "DocExtra": "`log` fails if called more than MaxLogCalls times in a program, or if the sum of logged bytes exceeds 1024 bytes.",
      "IntroducedVersion": 5,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 177,
      "Name": "itxn_begin",
      "Size": 1,
      "DocCost": "1",
      "Doc": "begin preparation of a new inner transaction in a new transaction group",
      "DocExtra": "`itxn_begin` initializes Sender to the application address; Fee to the minimum allowable, taking into account MinTxnFee and credit from overpaying in earlier transactions; FirstValid/LastValid to the values in the invoking transaction, and all other fields to zero or empty values.",
      "IntroducedVersion": 5,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 178,
      "Name": "itxn_field",
      "Args": [
        "any"
      ],
      "Size": 2,
      "ArgEnum": [
        "Sender",
        "Fee",
        "Note",
        "Receiver",
        "Amount",
        "CloseRemainderTo",
        "VotePK",
        "SelectionPK",
        "VoteFirst",
        "VoteLast",
        "VoteKeyDilution",
        "Type",
        "TypeEnum",
        "XferAsset",
        "AssetAmount",
        "AssetSender",
        "AssetReceiver",
        "AssetCloseTo",
        "ApplicationID",
        "OnCompletion",
        "ApplicationArgs",
        "Accounts",
        "ApprovalProgram",
        "ClearStateProgram",
        "RekeyTo",
        "ConfigAsset",
        "ConfigAssetTotal",
        "ConfigAssetDecimals",
        "ConfigAssetDefaultFrozen",
        "ConfigAssetUnitName",
        "ConfigAssetName",
        "ConfigAssetURL",
        "ConfigAssetMetadataHash",
        "ConfigAssetManager",
        "ConfigAssetReserve",
        "ConfigAssetFreeze",
        "ConfigAssetClawback",
        "FreezeAsset",
        "FreezeAssetAccount",
        "FreezeAssetFrozen",
        "Assets",
        "Applications",
        "GlobalNumUint",
        "GlobalNumByteSlice",
        "LocalNumUint",
        "LocalNumByteSlice",
        "ExtraProgramPages",
        "Nonparticipation",
        "StateProofPK",
        "ApprovalProgramPages",
        "ClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "address",
        "uint64",
        "[]byte",
        "address",
        "uint64",
        "address",
        "[32]byte",
        "[32]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "address",
        "address",
        "address",
        "uint64",
        "uint64",
        "[]byte",
        "address",
        "[]byte",
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "[]byte",
        "[]byte",
        "[32]byte",
        "address",
        "address",
        "address",
        "address",
        "uint64",
        "address",
        "bool",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "[]byte",
        "[]byte"
      ],
      "DocCost": "1",
      "Doc": "set field F of the current inner transaction to A",
      "DocExtra": "`itxn_field` fails if A is of the wrong type for F, including a byte array of the wrong size for use as an address when F is an address field. `itxn_field` also fails if A is an account, asset, or app that is not _available_, or an attempt is made extend an array field beyond the limit imposed by consensus parameters. (Addresses set into asset params of acfg transactions need not be _available_.)",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txn"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 179,
      "Name": "itxn_submit",
      "Size": 1,
      "DocCost": "1",
      "Doc": "execute the current inner transaction group. Fail if executing this group would exceed the inner transaction limit, or if any transaction in the group fails.",
      "DocExtra": "`itxn_submit` resets the current transaction so that it can not be resubmitted. A new `itxn_begin` is required to prepare another inner transaction.",
      "IntroducedVersion": 5,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 180,
      "Name": "itxn",
      "Returns": [
        "any"
      ],
      "Size": 2,
      "ArgEnum": [
        "Sender",
        "Fee",
        "FirstValid",
        "FirstValidTime",
        "LastValid",
        "Note",
        "Lease",
        "Receiver",
        "Amount",
        "CloseRemainderTo",
        "VotePK",
        "SelectionPK",
        "VoteFirst",
        "VoteLast",
        "VoteKeyDilution",
        "Type",
        "TypeEnum",
        "XferAsset",
        "AssetAmount",
        "AssetSender",
        "AssetReceiver",
        "AssetCloseTo",
        "GroupIndex",
        "TxID",
        "ApplicationID",
        "OnCompletion",
        "ApplicationArgs",
        "NumAppArgs",
        "Accounts",
        "NumAccounts",
        "ApprovalProgram",
        "ClearStateProgram",
        "RekeyTo",
        "ConfigAsset",
        "ConfigAssetTotal",
        "ConfigAssetDecimals",
        "ConfigAssetDefaultFrozen",
        "ConfigAssetUnitName",
        "ConfigAssetName",
        "ConfigAssetURL",
        "ConfigAssetMetadataHash",
        "ConfigAssetManager",
        "ConfigAssetReserve",
        "ConfigAssetFreeze",
        "ConfigAssetClawback",
        "FreezeAsset",
        "FreezeAssetAccount",
        "FreezeAssetFrozen",
        "Assets",
        "NumAssets",
        "Applications",
        "NumApplications",
        "GlobalNumUint",
        "GlobalNumByteSlice",
        "LocalNumUint",
        "LocalNumByteSlice",
        "ExtraProgramPages",
        "Nonparticipation",
        "Logs",
        "NumLogs",
        "CreatedAssetID",
        "CreatedApplicationID",
        "LastLog",
        "StateProofPK",
        "ApprovalProgramPages",
        "NumApprovalProgramPages",
        "ClearStateProgramPages",
        "NumClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "address",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[32]byte",
        "address",
        "uint64",
        "address",
        "[32]byte",
        "[32]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "address",
        "address",
        "address",
        "uint64",
        "[32]byte",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "address",
        "uint64",
        "[]byte",
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "[]byte",
        "[]byte",
        "[32]byte",
        "address",
        "address",
        "address",
        "address",
        "uint64",
        "address",
        "bool",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte",
        "uint64",
        "[]byte",
        "uint64"
      ],
      "DocCost": "1",
      "Doc": "field F of the last inner transaction",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txn"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 181,
      "Name": "itxna",
      "Returns": [
        "any"
      ],
      "Size": 3,
      "ArgEnum": [
        "ApplicationArgs",
        "Accounts",
        "Assets",
        "Applications",
        "Logs",
        "ApprovalProgramPages",
        "ClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte"
      ],
      "DocCost": "1",
      "Doc": "Ith value of the array field F of the last inner transaction",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        },
        {
          "Comment": "a transaction field array index",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 182,
      "Name": "itxn_next",
      "Size": 1,
      "DocCost": "1",
      "Doc": "begin preparation of a new inner transaction in the same transaction group",
      "DocExtra": "`itxn_next` initializes the transaction exactly as `itxn_begin` does",
      "IntroducedVersion": 6,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 183,
      "Name": "gitxn",
      "Returns": [
        "any"
      ],
      "Size": 3,
      "ArgEnum": [
        "Sender",
        "Fee",
        "FirstValid",
        "FirstValidTime",
        "LastValid",
        "Note",
        "Lease",
        "Receiver",
        "Amount",
        "CloseRemainderTo",
        "VotePK",
        "SelectionPK",
        "VoteFirst",
        "VoteLast",
        "VoteKeyDilution",
        "Type",
        "TypeEnum",
        "XferAsset",
        "AssetAmount",
        "AssetSender",
        "AssetReceiver",
        "AssetCloseTo",
        "GroupIndex",
        "TxID",
        "ApplicationID",
        "OnCompletion",
        "ApplicationArgs",
        "NumAppArgs",
        "Accounts",
        "NumAccounts",
        "ApprovalProgram",
        "ClearStateProgram",
        "RekeyTo",
        "ConfigAsset",
        "ConfigAssetTotal",
        "ConfigAssetDecimals",
        "ConfigAssetDefaultFrozen",
        "ConfigAssetUnitName",
        "ConfigAssetName",
        "ConfigAssetURL",
        "ConfigAssetMetadataHash",
        "ConfigAssetManager",
        "ConfigAssetReserve",
        "ConfigAssetFreeze",
        "ConfigAssetClawback",
        "FreezeAsset",
        "FreezeAssetAccount",
        "FreezeAssetFrozen",
        "Assets",
        "NumAssets",
        "Applications",
        "NumApplications",
        "GlobalNumUint",
        "GlobalNumByteSlice",
        "LocalNumUint",
        "LocalNumByteSlice",
        "ExtraProgramPages",
        "Nonparticipation",
        "Logs",
        "NumLogs",
        "CreatedAssetID",
        "CreatedApplicationID",
        "LastLog",
        "StateProofPK",
        "ApprovalProgramPages",
        "NumApprovalProgramPages",
        "ClearStateProgramPages",
        "NumClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "address",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[32]byte",
        "address",
        "uint64",
        "address",
        "[32]byte",
        "[32]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "address",
        "address",
        "address",
        "uint64",
        "[32]byte",
        "uint64",
        "uint64",
        "[]byte",
        "uint64",
        "address",
        "uint64",
        "[]byte",
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "[]byte",
        "[]byte",
        "[32]byte",
        "address",
        "address",
        "address",
        "address",
        "uint64",
        "address",
        "bool",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "uint64",
        "bool",
        "[]byte",
        "uint64",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte",
        "uint64",
        "[]byte",
        "uint64"
      ],
      "DocCost": "1",
      "Doc": "field F of the Tth transaction in the last inner group submitted",
      "ImmediateNote": [
        {
          "Comment": "transaction group index",
          "Encoding": "uint8",
          "Name": "T"
        },
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txn"
        }
      ],
      "IntroducedVersion": 6,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 184,
      "Name": "gitxna",
      "Returns": [
        "any"
      ],
      "Size": 4,
      "ArgEnum": [
        "ApplicationArgs",
        "Accounts",
        "Assets",
        "Applications",
        "Logs",
        "ApprovalProgramPages",
        "ClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte"
      ],
      "DocCost": "1",
      "Doc": "Ith value of the array field F from the Tth transaction in the last inner group submitted",
      "ImmediateNote": [
        {
          "Comment": "transaction group index",
          "Encoding": "uint8",
          "Name": "T"
        },
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        },
        {
          "Comment": "transaction field array index",
          "Encoding": "uint8",
          "Name": "I"
        }
      ],
      "IntroducedVersion": 6,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 185,
      "Name": "box_create",
      "Args": [
        "boxName",
        "uint64"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "create a box named A, of length B. Fail if the name A is empty or B exceeds 32,768. Returns 0 if A already existed, else 1",
      "DocExtra": "Newly created boxes are filled with 0 bytes. `box_create` will fail if the referenced box already exists with a different size. Otherwise, existing boxes are unchanged by `box_create`.",
      "IntroducedVersion": 8,
      "Groups": [
        "Box Access"
      ]
    },
    {
      "Opcode": 186,
      "Name": "box_extract",
      "Args": [
        "boxName",
        "uint64",
        "uint64"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "read C bytes from box A, starting at offset B. Fail if A does not exist, or the byte range is outside A's size.",
      "IntroducedVersion": 8,
      "Groups": [
        "Box Access"
      ]
    },
    {
      "Opcode": 187,
      "Name": "box_replace",
      "Args": [
        "boxName",
        "uint64",
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "write byte-array C into box A, starting at offset B. Fail if A does not exist, or the byte range is outside A's size.",
      "IntroducedVersion": 8,
      "Groups": [
        "Box Access"
      ]
    },
    {
      "Opcode": 188,
      "Name": "box_del",
      "Args": [
        "boxName"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "delete box named A if it exists. Return 1 if A existed, 0 otherwise",
      "IntroducedVersion": 8,
      "Groups": [
        "Box Access"
      ]
    },
    {
      "Opcode": 189,
      "Name": "box_len",
      "Args": [
        "boxName"
      ],
      "Returns": [
        "uint64",
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "X is the length of box A if A exists, else 0. Y is 1 if A exists, else 0.",
      "IntroducedVersion": 8,
      "Groups": [
        "Box Access"
      ]
    },
    {
      "Opcode": 190,
      "Name": "box_get",
      "Args": [
        "boxName"
      ],
      "Returns": [
        "[]byte",
        "bool"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "X is the contents of box A if A exists, else ''. Y is 1 if A exists, else 0.",
      "DocExtra": "For boxes that exceed 4,096 bytes, consider `box_create`, `box_extract`, and `box_replace`",
      "IntroducedVersion": 8,
      "Groups": [
        "Box Access"
      ]
    },
    {
      "Opcode": 191,
      "Name": "box_put",
      "Args": [
        "boxName",
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "replaces the contents of box A with byte-array B. Fails if A exists and len(B) != len(box A). Creates A if it does not exist",
      "DocExtra": "For boxes that exceed 4,096 bytes, consider `box_create`, `box_extract`, and `box_replace`",
      "IntroducedVersion": 8,
      "Groups": [
        "Box Access"
      ]
    },
    {
      "Opcode": 192,
      "Name": "txnas",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 2,
      "ArgEnum": [
        "ApplicationArgs",
        "Accounts",
        "Assets",
        "Applications",
        "Logs",
        "ApprovalProgramPages",
        "ClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte"
      ],
      "DocCost": "1",
      "Doc": "Ath value of the array field F of the current transaction",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 193,
      "Name": "gtxnas",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 3,
      "ArgEnum": [
        "ApplicationArgs",
        "Accounts",
        "Assets",
        "Applications",
        "Logs",
        "ApprovalProgramPages",
        "ClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte"
      ],
      "DocCost": "1",
      "Doc": "Ath value of the array field F from the Tth transaction in the current group",
      "ImmediateNote": [
        {
          "Comment": "transaction group index",
          "Encoding": "uint8",
          "Name": "T"
        },
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 194,
      "Name": "gtxnsas",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 2,
      "ArgEnum": [
        "ApplicationArgs",
        "Accounts",
        "Assets",
        "Applications",
        "Logs",
        "ApprovalProgramPages",
        "ClearStateProgramPages"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "address",
        "uint64",
        "uint64",
        "[]byte",
        "[]byte",
        "[]byte"
      ],
      "DocCost": "1",
      "Doc": "Bth value of the array field F from the Ath transaction in the current group",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        }
      ],
      "IntroducedVersion": 5,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 195,
      "Name": "args",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "Ath LogicSig argument",
      "IntroducedVersion": 5,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 196,
      "Name": "gloadss",
      "Args": [
        "uint64",
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "Bth scratch space value of the Ath transaction in the current group",
      "IntroducedVersion": 6,
      "Groups": [
        "Loading Values"
      ]
    },
    {
      "Opcode": 197,
      "Name": "itxnas",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 2,
      "DocCost": "1",
      "Doc": "Ath value of the array field F of the last inner transaction",
      "ImmediateNote": [
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        }
      ],
      "IntroducedVersion": 6,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 198,
      "Name": "gitxnas",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 3,
      "DocCost": "1",
      "Doc": "Ath value of the array field F from the Tth transaction in the last inner group submitted",
      "ImmediateNote": [
        {
          "Comment": "transaction group index",
          "Encoding": "uint8",
          "Name": "T"
        },
        {
          "Comment": "transaction field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "txna"
        }
      ],
      "IntroducedVersion": 6,
      "Groups": [
        "Inner Transactions"
      ]
    },
    {
      "Opcode": 208,
      "Name": "vrf_verify",
      "Args": [
        "[]byte",
        "[80]byte",
        "[32]byte"
      ],
      "Returns": [
        "[64]byte",
        "bool"
      ],
      "Size": 2,
      "ArgEnum": [
        "VrfAlgorand"
      ],
      "DocCost": "5700",
      "Doc": "Verify the proof B of message A against pubkey C. Returns vrf output and verification flag.",
      "DocExtra": "`VrfAlgorand` is the VRF used in Algorand. It is ECVRF-ED25519-SHA512-Elligator2, specified in the IETF internet draft [draft-irtf-cfrg-vrf-03](https://datatracker.ietf.org/doc/draft-irtf-cfrg-vrf/03/).",
      "ImmediateNote": [
        {
          "Comment": " parameters index",
          "Encoding": "uint8",
          "Name": "S",
          "Reference": "vrf_verify"
        }
      ],
      "IntroducedVersion": 7,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 209,
      "Name": "block",
      "Args": [
        "uint64"
      ],
      "Returns": [
        "any"
      ],
      "Size": 2,
      "ArgEnum": [
        "BlkSeed",
        "BlkTimestamp"
      ],
      "ArgEnumTypes": [
        "[]byte",
        "uint64"
      ],
      "DocCost": "1",
      "Doc": "field F of block A. Fail unless A falls between txn.LastValid-1002 and txn.FirstValid (exclusive)",
      "ImmediateNote": [
        {
          "Comment": " block field index",
          "Encoding": "uint8",
          "Name": "F",
          "Reference": "block"
        }
      ],
      "IntroducedVersion": 7,
      "Groups": [
        "State Access"
      ]
    },
    {
      "Opcode": 210,
      "Name": "box_splice",
      "Args": [
        "boxName",
        "uint64",
        "uint64",
        "[]byte"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "set box A to contain its previous bytes up to index B, followed by D, followed by the original bytes of A that began at index B+C.",
      "DocExtra": "Boxes are of constant length. If C \u003c len(D), then len(D)-C bytes will be removed from the end. If C \u003e len(D), zero bytes will be appended to the end to reach the box length.",
      "IntroducedVersion": 10,
      "Groups": [
        "Box Access"
      ]
    },
    {
      "Opcode": 211,
      "Name": "box_resize",
      "Args": [
        "boxName",
        "uint64"
      ],
      "Size": 1,
      "DocCost": "1",
      "Doc": "change the size of box named A to be of length B, adding zero bytes to end or removing bytes from the end, as needed. Fail if the name A is empty, A is not an existing box, or B exceeds 32,768.",
      "IntroducedVersion": 10,
      "Groups": [
        "Box Access"
      ]
    },
    {
      "Opcode": 224,
      "Name": "ec_add",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 2,
      "DocCost": "BN254g1=125; BN254g2=170; BLS12_381g1=205; BLS12_381g2=290",
      "Doc": "for curve points A and B, return the curve point A + B",
      "DocExtra": "A and B are curve points in affine representation: field element X concatenated with field element Y. Field element `Z` is encoded as follows.\nFor the base field elements (Fp), `Z` is encoded as a big-endian number and must be lower than the field modulus.\nFor the quadratic field extension (Fp2), `Z` is encoded as the concatenation of the individual encoding of the coefficients. For an Fp2 element of the form `Z = Z0 + Z1 i`, where `i` is a formal quadratic non-residue, the encoding of Z is the concatenation of the encoding of `Z0` and `Z1` in this order. (`Z0` and `Z1` must be less than the field modulus).\n\nThe point at infinity is encoded as `(X,Y) = (0,0)`.\nGroups G1 and G2 are denoted additively.\n\nFails if A or B is not in G.\nA and/or B are allowed to be the point at infinity.\nDoes _not_ check if A and B are in the main prime-order subgroup.",
      "ImmediateNote": [
        {
          "Comment": "curve index",
          "Encoding": "uint8",
          "Name": "G",
          "Reference": "EC"
        }
      ],
      "IntroducedVersion": 10,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 225,
      "Name": "ec_scalar_mul",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 2,
      "DocCost": "BN254g1=1810; BN254g2=3430; BLS12_381g1=2950; BLS12_381g2=6530",
      "Doc": "for curve point A and scalar B, return the curve point BA, the point A multiplied by the scalar B.",
      "DocExtra": "A is a curve point encoded and checked as described in `ec_add`. Scalar B is interpreted as a big-endian unsigned integer. Fails if B exceeds 32 bytes.",
      "ImmediateNote": [
        {
          "Comment": "curve index",
          "Encoding": "uint8",
          "Name": "G",
          "Reference": "EC"
        }
      ],
      "IntroducedVersion": 10,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 226,
      "Name": "ec_pairing_check",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 2,
      "DocCost": "BN254g1=8000 + 7400 per 64 bytes of B; BN254g2=8000 + 7400 per 128 bytes of B; BLS12_381g1=13000 + 10000 per 96 bytes of B; BLS12_381g2=13000 + 10000 per 192 bytes of B",
      "Doc": "1 if the product of the pairing of each point in A with its respective point in B is equal to the identity element of the target group Gt, else 0",
      "DocExtra": "A and B are concatenated points, encoded and checked as described in `ec_add`. A contains points of the group G, B contains points of the associated group (G2 if G is G1, and vice versa). Fails if A and B have a different number of points, or if any point is not in its described group or outside the main prime-order subgroup - a stronger condition than other opcodes. AVM values are limited to 4096 bytes, so `ec_pairing_check` is limited by the size of the points in the groups being operated upon.",
      "ImmediateNote": [
        {
          "Comment": "curve index",
          "Encoding": "uint8",
          "Name": "G",
          "Reference": "EC"
        }
      ],
      "IntroducedVersion": 10,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 227,
      "Name": "ec_multi_scalar_mul",
      "Args": [
        "[]byte",
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 2,
      "DocCost": "BN254g1=3600 + 90 per 32 bytes of B; BN254g2=7200 + 270 per 32 bytes of B; BLS12_381g1=6500 + 95 per 32 bytes of B; BLS12_381g2=14850 + 485 per 32 bytes of B",
      "Doc": "for curve points A and scalars B, return curve point B0A0 + B1A1 + B2A2 + ... + BnAn",
      "DocExtra": "A is a list of concatenated points, encoded and checked as described in `ec_add`. B is a list of concatenated scalars which, unlike ec_scalar_mul, must all be exactly 32 bytes long.\nThe name `ec_multi_scalar_mul` was chosen to reflect common usage, but a more consistent name would be `ec_multi_scalar_mul`. AVM values are limited to 4096 bytes, so `ec_multi_scalar_mul` is limited by the size of the points in the group being operated upon.",
      "ImmediateNote": [
        {
          "Comment": "curve index",
          "Encoding": "uint8",
          "Name": "G",
          "Reference": "EC"
        }
      ],
      "IntroducedVersion": 10,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 228,
      "Name": "ec_subgroup_check",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "bool"
      ],
      "Size": 2,
      "DocCost": "BN254g1=20; BN254g2=3100; BLS12_381g1=1850; BLS12_381g2=2340",
      "Doc": "1 if A is in the main prime-order subgroup of G (including the point at infinity) else 0. Program fails if A is not in G at all.",
      "ImmediateNote": [
        {
          "Comment": "curve index",
          "Encoding": "uint8",
          "Name": "G",
          "Reference": "EC"
        }
      ],
      "IntroducedVersion": 10,
      "Groups": [
        "Cryptography"
      ]
    },
    {
      "Opcode": 229,
      "Name": "ec_map_to",
      "Args": [
        "[]byte"
      ],
      "Returns": [
        "[]byte"
      ],
      "Size": 2,
      "DocCost": "BN254g1=630; BN254g2=3300; BLS12_381g1=1950; BLS12_381g2=8150",
      "Doc": "maps field element A to group G",
      "DocExtra": "BN254 points are mapped by the SVDW map. BLS12-381 points are mapped by the SSWU map.\nG1 element inputs are base field elements and G2 element inputs are quadratic field elements, with nearly the same encoding rules (for field elements) as defined in `ec_add`. There is one difference of encoding rule: G1 element inputs do not need to be 0-padded if they fit in less than 32 bytes for BN254 and less than 48 bytes for BLS12-381. (As usual, the empty byte array represents 0.) G2 elements inputs need to be always have the required size.",
      "ImmediateNote": [
        {
          "Comment": "curve index",
          "Encoding": "uint8",
          "Name": "G",
          "Reference": "EC"
        }
      ],
      "IntroducedVersion": 10,
      "Groups": [
        "Cryptography"
      ]
    }
  ]
}
''';