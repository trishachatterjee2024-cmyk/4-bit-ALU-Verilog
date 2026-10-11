\# 4-Bit ALU Design and Exhaustive Verification



\## Overview

This project implements a 4-bit Arithmetic Logic Unit (ALU) using Verilog HDL. The ALU performs eight arithmetic and logical operations and generates status flags. A self-checking testbench is used to verify the design.



\## Features

\- 4-bit inputs A and B

\- Eight arithmetic and logical operations

\- Carry flag

\- Zero flag

\- Borrow flag

\- Exhaustive verification using a self-checking testbench



\## Supported Operations



| Select | Operation | Description |

|---|---|---|

| 000 | ADD | A + B |

| 001 | SUB | A - B |

| 010 | AND | Bitwise AND |

| 011 | OR | Bitwise OR |

| 100 | XOR | Bitwise XOR |

| 101 | NOT | Bitwise NOT of A |

| 110 | INC | Increment A by 1 |

| 111 | PASS B | Output B |



\## Verification

The testbench checks all combinations of the two 4-bit inputs and the 3-bit operation selector.



\- Input A combinations: 16

\- Input B combinations: 16

\- Operations: 8

\- Total test combinations: 2,048

\- Expected result: 2,048 passed, 0 failed



The testbench checks the result and the carry, zero, and borrow flags against a reference model.



\## Tools Used

\- Verilog HDL

\- EDA Playground

\- Icarus Verilog

\- EPWave



\## Project Files

\- `design.sv` — ALU RTL design

\- `testbench.sv` — Exhaustive self-checking testbench

\- `alu4.vcd` — Simulation waveform data

\- `alu4\_waveform.png` — Waveform screenshot



\## Simulation Waveform

!\[ALU Simulation Waveform](alu4\_waveform.png)



\## Future Improvements

\- Add signed arithmetic support

\- Extend the ALU to 8-bit or 16-bit operations

\- Implement the design on an FPGA

