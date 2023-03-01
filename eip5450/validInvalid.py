#!/bin/env python
import os

TESTS_PATH = "/home/hugo/workspace/tests"
TEST_SUITE = "EOFTestsFiller/EIP5450"
FILLER_NAME = "validInvalidFiller.yml"
FILLER_PATH = TESTS_PATH + "/src/" + TEST_SUITE + "/" + FILLER_NAME
SP6 = "      "

SKIP_OPCODES=["JUMP", "JUMPI", "RJUMPI", "RJUMPV", "CALLCODE", "SELFDESTRUCT"]

class Test:
    def __init__(self):
        self.tests = []
    def _generate_fillers(self):
        fillers = []
        filler1 = []
        filler2 = []
        i = 0
        for test in self.tests:
            description = test[0]
            asm_codes = test[1]
            asm_summary = test[2]
            valid = test[3]
            
            filler1.append(SP6 + " EOF1V{0:04d} {1}".format(i + 1, description))

            filler2.append(SP6 + "# Data: {:d}".format(i))
            filler2.append(SP6 + "# EOF1V{0:04d} {1}".format(i + 1, description))

            params = ""
            if len(asm_codes) == 1:
                if asm_summary:
                    filler2.append(SP6 + "# Code: %s" % asm_summary[0])
                else:
                    filler2.append(SP6 + "# Code: " + asm_codes[0])
                evm = os.popen("mnem2evm \"%s\"" % asm_codes[0]).read()
                params = "c:%s" % evm
            else:
                j = 0
                for ty, asm in asm_codes:
                    if asm_summary:
                        filler2.append(SP6 + "# Code[{:d}](Types: {}): {}".format(j, ty, asm_summary[j]))
                    else:
                        filler2.append(SP6 + "# Code[{:d}](Types: {}): {}".format(j, ty, asm))
                    evm = os.popen("mnem2evm \"%s\"" % asm).read().strip()
                    params += "C:%s:%s " % (ty, evm)
                    j += 1

            eof = os.popen("eof_gen %s" % params).read().split('\n')[-2]
            yul_initcode ="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"" + eof + "\" }"
            yul_initcode_esc = yul_initcode.replace("\"", "\\\"")
            eof_initcode = os.popen("yul_comp \"%s\"" % yul_initcode_esc).read().strip()

            #print(os.popen("t8n-runner --t8ntool /bin/evm --hard-fork Shanghai --data 0x%s  --gas 0xffffff" % eof_initcode).read())

            if asm_summary:
                label = "invalid"
                if valid: label = "valid"
                # TODO: Retesteth not accepting yul-eof
                #filler2.append(SP6 + "- ':label {} :yul-eof {}'".format(label, yul_initcode))
                filler2.append(SP6 + "- ':label {} :raw 0x{}'".format(label, eof_initcode))
            else:
                filler2.append(SP6 + "- |")
                if valid:
                    filler2.append(SP6 + "  :label valid :raw 0x")
                else:
                    filler2.append(SP6 + "  :label invalid :raw 0x")

                filler2.append(SP6 + "    # EOF Initcode")
                desc = os.popen("eof_desc \"%s\"" % eof_initcode).read().strip().split('\n')

                j = 0
                for line in desc:
                    if j < len(desc) - 2:
                        filler2.append(SP6 + "    {}".format(line))
                    j += 1
                filler2.append(SP6 + "    # EOF deployed code (part of data section)")

                eof_desc = os.popen("eof_desc \"%s\"" % eof).read().strip().split('\n')
                for line in eof_desc:
                    filler2.append(SP6 + "    {}".format(line))
                i+=1
        fillers.append(filler1)
        fillers.append(filler2)
        return fillers

    def add_clean(self, description, asm_codes, asm_summary, valid=True):
        self.tests.append((description, asm_codes, asm_summary, valid))
    def add(self, description, asm_codes, valid=True):
        self.tests.append((description, asm_codes, None, valid))
    def fill(self):
        fillers = self._generate_fillers()
        print(FILLER_PATH)
        output = ""
        lines = ""
        f_no = 1
        ffound = False
        if os.path.exists(FILLER_PATH):
            with open(FILLER_PATH, "r") as f:
                lines = f.readlines()
            for line in lines:
                if "<@f" + str(f_no) in line:
                    ffound = False
                    f_no += 1

                if ffound:
                    continue

                output += line
                if ">@f" + str(f_no) in line:
                    for f in fillers[f_no - 1]:
                        output += f + '\n'
                    ffound = True

        with open(FILLER_PATH, "w") as f:
            f.write(output)
            


test = Test()

# Test Valid EOF
test.add("(Valid) Code with branches having the same stack height",
         ["PUSH1(0) RJUMPI(label_true) PUSH1(1) PUSH1(2) RJUMP(exit) label_true: PUSH1(3) PUSH1(4) exit: STOP"])
test.add("(Valid) Jump table",
         ["PUSH1(0) RJUMPV(case1,case2) PUSH1(1) PUSH1(2) RJUMP(exit) case1: PUSH1(3) PUSH1(4) RJUMP(exit) case2: PUSH1(5) PUSH1(6) exit: STOP"])


test.add("(Valid) Infinite loop", ["start: PUSH1(0) PUSH1(1) POP POP RJUMP(start)"])
test.add("(Valid) CALLF branches with the same total of outputs",
         [("0:0", "PUSH1(0) RJUMPI(label_true) label_false: CALLF(1) RJUMP(exit) label_true: CALLF(2) exit: STOP"),
          ("0:1", "ADDRESS STOP"),
          ("0:1", "CODESIZE STOP")])
test.add("(Valid) CALLF inputs",
         [("0:0", "CALLF(0) STOP"),
          ("1:0", "PUSH1(0) CALLF(1) STOP"),
          ("2:0", "PUSH1(0) PUSH1(0) CALLF(2) STOP"),
          ("127:0", "DUP1 " * 126 + "CALLF(3) STOP")])


# Test all opcodes requiring stack elements as input
opcode_list = os.popen("oplist").read().split('\n')[:-1]
terminating_opcodes = []
op_names = {}
stack_reqs = {}
for op in opcode_list:
    opname = os.popen("opinfo %s --name" % op).read().strip()
    op_names[op] = opname

    sr = int(os.popen("opinfo %s --inputs" % op).read().strip())
    stack_reqs[op] = sr

    if sr > 0:
        # Avoid some opcodes
        if opname in SKIP_OPCODES:
            continue

        pushes="PUSH1(1)"
        if sr > 1:
            while sr > 1:
                pushes= pushes + " DUP1"
                sr -= 1
        asm=pushes + " " + opname

        is_terminating = os.popen("opinfo %s --is-terminating" % op).read().strip()
        if is_terminating == "false":
            asm = asm + " STOP"
        elif is_terminating == "true":
            terminating_opcodes.append(op)
        else:
            print("ERROR: ", opname, "is_terminating: ", is_terminating)
        test.add("(Valid) Validate input for " +opname + " opcode", [asm])

# Test ending with terminating opcodes
for op in terminating_opcodes:
    if op in SKIP_OPCODES:
        continue
    asm = "PUSH1(1) POP "
    pushes = ""
    sr = stack_reqs[op]
    if sr > 0:
        asm = asm + "PUSH1(0) "
        while sr > 1:
            pushes= pushes + "DUP1 "
            sr -= 1
        if pushes != "":
            asm = asm + pushes
    opname = op_names[op]
    asm = asm + opname
    test.add("(Valid) Containing terminating opcode " + opname + " at the end", [asm])

test.add("(Valid) Loop ending with unconditional RJUMP (a)",
         ["start: RJUMP(start)"])
test.add("(Valid) Loop ending with unconditional RJUMP (b)",
         ["PUSH1(10) start: PUSH1(1) SWAP1 SUB DUP1 RJUMPI(end) STOP end: RJUMP(start)"])
test.add("(Valid) Functions ending with RETF",
         [("0:0", "PUSH1(0) CALLF(1) STOP"),
          ("1:1", "RETF"),
          ("0:2", "PUSH1(0) PUSH2(0x0000) RETF")])

# Test stack is not required to be empty on terminating instruction
for op in opcode_list:
    opname = op_names[op]
    if op in terminating_opcodes and opname not in SKIP_OPCODES and op != "RETF":
        sr = stack_reqs[op]
        asm = "PUSH1(0) DUP1 DUP1 "

        if sr > 0:
            asm = asm + "DUP1 "
            while sr > 1:
                asm = asm + "DUP1 "
                sr -= 1
        asm = asm + opname
        test.add("(Valid) Stack is not required to be empty on terminating instruction " + opname, [asm])

test.add("(Valid) RETF returning maximum number of outputs (127)",
         [("0:0", "CALLF(1) STOP"),
          ("0:127", "PUSH1(0) " + ("DUP1 " * 126) + "RETF")])


# Test Invalid EOF
test.add("(Invalid) Stack height mismatch for different paths (a)",
         ["PUSH1(0) RJUMPI(label_true) PUSH1(1) label_true: PUSH1(2) STOP"], valid=False)
test.add("(Invalid) Stack height mismatch for different paths (b)",
         ["PUSH1(0) RJUMPI(label_true) label_false: PUSH1(1) RJUMP(exit) label_true: PUSH1(2) PUSH1(3) exit: STOP"], valid=False)
test.add("(Invalid) Calls returning different number of outputs",
         [("0:0", "PUSH1(0) RJUMPI(label_true) label_false: CALLF(1) RJUMP(exit) label_true: CALLF(2) exit: STOP"),
          ("0:1", "PUSH1(1) RETF"),
          ("0:2", "PUSH1(1) DUP1 RETF")], valid=False)
test.add("(Invalid) Pushing loop",
         ["start: PUSH1(0) RJUMP(start)"], valid=False)
test.add("(Invalid) Popping loop",
         ["PUSH1(0) DUP1 DUP1 start: POP RJUMP(start)"], valid=False)
test.add("(Invalid) Jump table with different stack heights",
         ["PUSH1(0) RJUMPV(case1,case2) PUSH1(1) RJUMP(exit) case1: PUSH1(2) PUSH1(3) RJUMP(exit) case2: PUSH1(3) PUSH1(4) PUSH1(5) exit: STOP"], valid=False)

# Test stack underflow
for op in opcode_list:
    opname = op_names[op]
    if opname in SKIP_OPCODES:
        continue
    sr = stack_reqs[op]
    if sr > 0:
        asm = opname + " STOP"
        if sr > 1:
            asm = "PUSH1(1) " * (sr - 1) + opname
            if op not in terminating_opcodes:
                asm = asm + " STOP"
        test.add("(Invalid) Stack underflow for opcode " + opname, [asm], valid=False)

test.add("(Invalid) Calling function without enough stack items: Function 0 calls Function 1 without enough parameters",
         [("0:0", "CALLF(1) STOP"),
          ("1:0", "PUSH1(0) DUP1 CALLF(2)"),
          ("2:0", "POP POP RETF")], valid=False)

test.add("(Invalid) Calling function without enough stack items: Function 1 calls Function 2 with enough parameters",
         [("0:0", "PUSH1(0) CALLF(1) STOP"),
          ("1:0", "PUSH1(0) CALLF(2)"),
          ("2:0", "POP POP RETF")], valid=False)

test.add("(Invalid) Calling function without enough stack items: Function 0 calls Function 1 without enought parameters, Function 1 calls Function 2 without enough parameers",
         [("0:0", "CALLF(1) STOP"),
          ("1:0", "PUSH1(0) CALLF(2)"),
          ("2:0", "POP POP CALLF(3)")], valid=False)

test.add_clean("(Invalid) Stack Overflow: Function pushing more than 1024 items to the stack",
         ["PUSH1(0) " * 1024],
         ["PUSH1(0) (1024 Times)"], valid=False)

test.add_clean("(Invalid) Stack Overflow: Function 1 when called by Function 0 pushes more than 1024 items to the stack",
               [("0:0", "PUSH1(0) " * 1020 + "CALLF(1)"),
                ("0:5", "PUSH1(0) " * 5 + "RETF")],
               ["PUSH1(0) (1020 Times) CALLF(1)",
                "PUSH1(0) (5 Times) RETF"], valid=False)

test.add("(Invalid) Function ending with non-terminating instruction (a)",
         ["PUSH1(0)"], valid=False)

test.add("(Invalid) Function ending with non-terminating instruction (b)",
         ["PUSH1(0) RJUMPI(exit) STOP exit: NOP"], valid=False)

test.add("(Invalid) Function ending with non-terminating instruction (c)",
         ["PUSH1(0) RJUMPV(case1,case2) INVALID case1: STOP case2: NOP"], valid=False)

# Test function containing unreachable code
for op in terminating_opcodes:
    opname = op_names[op]
    if opname in SKIP_OPCODES:
        continue
    sr = stack_reqs[op]
    asm = ""
    if sr > 0:
        asm = "PUSH1(0) " * sr 
    asm = asm + opname + " STOP"
    test.add("(Invalid) Function containing unreachable code after " + opname, [asm], valid=False)

test.add("(Invalid) Unreachable code after RJUMP",
         ["RJUMP(start) PUSH1(0) start: PUSH1(0) STOP"], valid=False)

test.add("(Invalid) Unreachable code after infinite loop",
         ["RJUMP(start) PUSH1(0) start: PUSH1(0) POP RJUMP(start) STOP"], valid=False)

test.fill()



