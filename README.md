# Arithmetic Logic Unit (ALU) – RTL Design & Verification

##  About This Project
This project is a **hardware implementation of an Arithmetic Logic Unit (ALU)** using **Verilog at RTL level**.

The goal of this project was not just to write Verilog code, but to **understand how basic boolean logic and arithmetic operations come together to form a core block of a processor**.

The ALU is designed step-by-step and verified thoroughly using both **self-checking** and **random testbenches**.

---

##  Why an ALU?
In any processor, all calculations — whether it is addition, subtraction, comparisons, or decision-making — are ultimately performed by the **ALU**.

By building an ALU from scratch, this project helped me understand:
- How arithmetic operations are implemented in hardware
- The difference between signed and unsigned operations
- How processors detect conditions using flags

---

##  What This ALU Can Do
The ALU supports the following operations:

- Arithmetic:
  - Addition
  - Subtraction
- Logical:
  - AND
  - OR
  - XOR
- Shift operations:
  - Logical left shift
  - Logical right shift

The design is **parameterized**, so the same ALU can be reused for different bit-widths (8-bit, 16-bit, 32-bit, etc.).

---

##  Operation Selection (OP Codes)

| OP Code | Operation |
|--------|-----------|
| 0000 | ADD |
| 0001 | SUB |
| 0010 | AND |
| 0011 | OR |
| 0100 | XOR |
| 0101 | SHIFT LEFT |
| 0110 | SHIFT RIGHT |

---

##  Status Flags Explained

The ALU generates three important flags:

###  CARRY
- Indicates carry-out during **unsigned addition**
- Useful for multi-word arithmetic

###  OVERFLOW
- Indicates **signed arithmetic overflow**
- Occurs when the result cannot be represented within the selected bit-width

###  ZERO
- Set when the output result is zero
- Commonly used in conditional branching in processors

---

##  Verification Approach
Verification was done in multiple stages to ensure correctness:

1. **Basic testbench** to verify functionality
2. **Self-checking testbench** that automatically compares ALU output with expected results
3. **Random stress testing** to catch corner cases

The testbench reports results as **PASS / FAIL**, similar to industry verification practices.

Example output:
PASS | A=10 B=5 OP=0000 | RESULT=15
PASS | A=32767 B=1 OP=0000 | RESULT=-32768


---

##  Tools Used
- Verilog HDL
- EDA Playground (Icarus Verilog)
- GTKWave (for waveform inspection)

---

##  Project Structure
verilog/ → ALU RTL design files
testbench/ → Verification testbenches
results/ → Simulation outputs
README.md → Project documentation


---

##  How to Run
1. Open EDA Playground
2. Load the ALU design file from `verilog/`
3. Load the required testbench from `testbench/`
4. Run the simulation
5. Observe PASS / FAIL messages in the console

---

## 🔹 What I Learned
Through this project, I learned:
- How boolean logic scales into real hardware blocks
- How signed and unsigned arithmetic differ in hardware
- How overflow is detected in processors
- How proper verification is as important as design
- How real RTL projects are structured and versioned

---

## 🔹 Conclusion
This project helped bridge the gap between **theory (boolean logic)** and **real hardware design**.  
It serves as a strong foundation for future studies in digital design, computer architecture, and VLSI.

---
