# Synchronous FIFO Design and Verification in Verilog

This project implements a **parameterized synchronous FIFO (First-In First-Out)** memory buffer using Verilog HDL. The design is verified with a detailed **testbench**, console monitoring using `$monitor`, and waveform analysis.
---

## Overview

A FIFO is a sequential memory buffer that outputs data in the order it was written. This design is fully synchronous, meaning both read and write operations are triggered on the same clock domain.

---

## Module Interface

### Inputs
| Signal     | Width  | Description                        |
|------------|--------|------------------------------------|
| `clk`      | 1-bit  | Global clock signal                |
| `rst`      | 1-bit  | Synchronous active-high reset      |
| `w_en`     | 1-bit  | Write enable                       |
| `r_en`     | 1-bit  | Read enable                        |
| `data_in`  | 8-bit  | Data input to be written to FIFO   |

### Outputs
| Signal     | Width  | Description                        |
|------------|--------|------------------------------------|
| `data_out` | 8-bit  | Data read from FIFO                |
| `full`     | 1-bit  | Indicates FIFO is full             |
| `empty`    | 1-bit  | Indicates FIFO is empty            |

---

## Working

- FIFO is implemented as a **circular buffer** using read and write pointers (`r_ptr`, `w_ptr`).
- A `count` variable tracks the number of valid elements.
- `full` is set when `count == depth`.
- `empty` is set when `count == 0`.

  ## Waveform Output

Below is a sample waveform showing:

- Write of 4 values (10, 20, 30, 40) (decimal)
- Read back in same order
- `full` and `empty` flag transitions

![Waveform](https://github.com/Nihal-210/Synchronous_FIFO/blob/main/Waveform.png) 




