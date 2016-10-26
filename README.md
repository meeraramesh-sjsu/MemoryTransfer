# Memory To Memory Transfer using Verilog HDL
### This project  is about transferring from one 8X8 memory to another 4X8 memory using a controller and
### Sequential and combinational logic elements
### The controller was designed using Counter-Decoder scheme
## Controller
### Controller consists of 5 bit up-counter and decoders to generate write/read enable signals for both the
### memories and increment signals to increment the address bit of counter corresponding to both memories. Also there is reset
### signal input to counter, so when counter receives a reset signal both the counters are reset regardless of the value of their
### outputs.
## Simultation
### In simulation phase, two 8-bit data packets from an 8x8 source memory (memory A), is downloaded and processed
### according to their relative contents and the result is stored in an 8x4 target memory (memory B)