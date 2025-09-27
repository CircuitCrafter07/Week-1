# RTL Design Workshop – Day 1

## Introduction
This workshop is focused on **RTL Design using Verilog HDL**.  
By the end of this session, you will understand:
- Basics of Verilog
- RTL Design flow
- Simulation and Synthesis process
- Writing testbenches
- Debugging using waveforms

---

## What is RTL?
**RTL (Register Transfer Level)** is a design abstraction that describes digital circuits in terms of:
- **Data flow** between registers  
- **Operations** performed on data  

It is the foundation for **digital circuit design** before synthesis into gate-level hardware.
<img width="1203" height="601" alt="image" src="https://github.com/user-attachments/assets/1c79a27d-d786-4eb9-ae36-a81df06f2ca7" />

---
2. Getting Started with iverilog
iverilog is an open-source simulator for Verilog. Here’s the typical simulation flow:
<img width="1253" height="470" alt="image" src="https://github.com/user-attachments/assets/38293b80-1c5d-4ebf-bb20-8da934b4e69d" />
Both the design and testbench are provided as input to iverilog.
The simulator produces a .vcd file for waveform viewing in GTKWave.

## Design Flow

1. **Specification** – Define the functionality.  
2. **RTL Coding** – Implement in Verilog HDL.  
3. **Simulation** – Verify correctness with testbench.  
4. **Synthesis** – Convert RTL into gate-level netlist.  
5. **Implementation** – Map to FPGA/ASIC.  

---
3. Lab: Simulating a 2-to-1 Multiplexer
Let’s simulate a simple 2-to-1 multiplexer using iverilog!
--
Step 1: Clone the Workshop Repository
git clone https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git
cd sky130RTLDesignAndSynthesisWorkshop/verilog_files
Step 2: Install Required Tools
sudo apt install iverilog
sudo apt install gtkwave
Step 3: Simulate the Design
Compile the design and testbench:

iverilog good_mux.v tb_good_mux.v
Run the simulation:

./a.out
View the waveform:

gtkwave tb_good_mux.vcd


## Verilog Basics

### Example 1: 2:1 Multiplexer
```verilog
module mux2to1 (
    input  wire a,      // Input 0
    input  wire b,      // Input 1
    input  wire sel,    // Select line
    output wire y       // Output
);
    assign y = (sel) ? b : a;
endmodule

