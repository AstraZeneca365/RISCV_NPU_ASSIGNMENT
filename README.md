# RISCV_NPU_ASSIGNMENT

# 1)4-input round robin arbiter

## what is an arbiter?
An arbiter is a circuit used when multiple devices request access to a shared resource at the same time. Since only one requester can be granted access at a time, the arbiter decides which request should be served. In a fixed priority arbiter, one requester may continuously get preference over others. A round robin arbiter avoids this by changing the priority after every grant.

The arbiter accepts four request inputs (`req[3:0]`) and generates four grant outputs (`gnt[3:0]`). Only one requester is granted at a time.

A priority register(2 bits) determines which requester is checked first. After each grant, priority moves to the next requester in cyclic order which ensures fair access to every requester.

In this code, the default priority (highest priority)  is set to r0 (req[0]).

## Test cases
1. Request r0 only
2. Request r1 only
3. Multiple requests active (`1011`)
4. All requests active (`1111`) to verify round robin rotation

## Expected results

1. Test 1 (req = 0001): r0 is granted (gnt = 0001). Priority updates to r1 (01).
2. Test 2 (req = 0010): r1 is granted (gnt = 0010). Priority updates to r2 (10).
3. Test 3 (req = 1011): r3 is granted (gnt = 1000) because the current priority is still r2, which is not requesting (so its not granted). Priority then updates to r0 (00).
4. When all requests are active, the grants should rotate as follows:

                                       0001 -> 0010 -> 0100 -> 1000 -> ...

The waveform(in the image) verifies this behaviour that only one requester is granted per cycle and priority rotates after each grant.



# 2) Optimized multiplier for 4 bit inputs

## Working of the optimized multiplier
The optimized multiplier uses add-shift method to multiply 2 4bit unsigned inputs in 4 clock cycles. 

M-> stores the multiplicand
Q-> stores the multiplier
A-> accumulator for partial sums
C-> stores the carry bit
count-> tracks the four multiplication cycles
product-> stores the final 8 bit result

During each cycle, if Q[0] = 1, M is added to A otherwise addition is skipped (this can be achieved by using a 2to1 MUX) The combined register {C,A,Q} is then shifted right by one bit. This repeats for four cycles after which {A,Q} contains the final 8 bit product.
