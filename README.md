# RPN Calculator (Racket)

This is a simple Reverse Polish Notation (RPN) calculator written in Racket. It can perform various mathematical operations, such as addition, subtraction, multiplication, division, and many more. The calculator also supports functions for trigonometry, logarithms, and other mathematical operations.

## Description

This calculator uses Reverse Polish Notation (RPN), meaning that operations are performed after specifying the operands. For example:

- `3 4 +` is equivalent to `3 + 4`, the result is `7`.
- `5 2 *` is equivalent to `5 * 2`, the result is `10`.

### Supported Operations:

- Basic arithmetic operations: `+`, `-`, `*`, `/`, `%`, `^`
- Standard math functions: `sqrt`, `log`, `round`, `sin`, `cos`, `tan`, `asin`, `acos`, and more.
- Trigonometric functions and their inverses: `sinh`, `cosh`, `tanh`, `asin`, `acos`, `atan`, etc.
- Special functions: factorial, subfactorial (`sfact`).

### Example:

For evaluating the expression:

```
3 4 + 2 * 5 /
```

1. First, `3 + 4` is calculated, resulting in `7`.
2. Then, `7 * 2` is calculated, resulting in `14`.
3. Finally, `14 / 5` is calculated, resulting in `2.8`.

## Installation

   ```bash
   git clone https://github.com/Ad4ndi/rpn-repl.git
   cd rpn-repl
   racket repl.rkt
   ```

## Functions

Supported functions:

- `+, -, *, /, ^` — arithmetic operations.
- `sqrt` — square root.
- `log` — natural logarithm.
- `round` — round number.
- `sin, cos, tan` — trigonometric functions.
- `asin, acos, atan` — inverse trigonometric functions.
- `fact` — factorial.

And many more!
