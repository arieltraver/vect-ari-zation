# Vect-Ari-zation
## Assembly exercise
The point of this project is to work directly with some of the AVX instructions in order to better understand how vectorization is happening at the instruction level.

This project is written with x86-64 assembly for Linux on Intel. To test the executables, you may wish to clone this repo on a VM matching these specs. I used an EC2 instance running Ubuntu.

There (will be) two versions of the assembly function: one which loops within the assembly code through the 256-bit-aligned parts of the array, and the other which only performs dot product on a single, 256-bit section. For the latter, the outer C program will call this on several sections of the array in parallel.

At the end, I (will) perform some analysis on the performance of these programs as well as a naiive program which performs dot product without AVX instructions (and core-dump it to ensure that it is not engaging in any compile-time vectorization).

References
* [summation](https://en.algorithmica.org/hpc/simd/reduction/)
* [general assembly](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
* [c call syntax](https://staffwww.fullcoll.edu/aclifton/cs241/lecture-asm-to-c-interop.html)
* [avx](https://docs.oracle.com/cd/E19120-01/open.solaris/817-5477/eojde/index.html)
* [more avx](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions)
* [extraction](https://commons.wikimedia.org/wiki/File:Vextractf128.svg)
* [intel intrinsics guide] (https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)
* [control byte description](https://en.wikibooks.org/wiki/X86_Assembly/SSE#IMM8_control_byte_description)
