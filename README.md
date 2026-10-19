# RISCV_NPU_ASSIGNMENT

# 1)4-input round robin arbiter

The arbiter accepts four request inputs (`req[3:0]`) and generates four grant outputs (`gnt[3:0]`). Only one requester is granted at a time.

A priority register(2 bits) determines which requester is checked first. After each grant, priority moves to the next requester in cyclic order, ensuring fair access.

## Test cases
1. Request r0 only
2. Request r1 only
3. Multiple requests active (`1011`)
4. All requests active (`1111`) to verify round robin rotation

## Expected result
When all requests are active, the grants should rotate as follows:

`0001 -> 0010 -> 0100 -> 1000 -> ...`

The waveform(in the image) verifies this behaviour that only one requester is granted per cycle and priority rotates after each grant.
