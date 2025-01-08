This project contains an assembly program written for 8086 microprocessor emulation. It is a multi-functional calculator that provides the following features:

Simple Calculator:

Perform basic arithmetic operations like:
Addition
Subtraction
Multiplication
Division (including handling division by zero and displaying floating-point results).
Base Converter:

Convert numbers between different numeral systems:
Decimal to Binary
Decimal to Hexadecimal
Binary to Decimal
Hexadecimal to Decimal
Temperature Converter:

Convert temperature units between:
Celsius, Fahrenheit, and Kelvin.
Key Features:
User Interface: A simple and intuitive prompt-driven interface implemented using DOS interrupts (INT 21H) for user inputs and outputs.
Error Handling: Includes checks for invalid inputs, division by zero, and other boundary cases (e.g., binary and hexadecimal validation).
Modular Design: Organized using macros (e.g., PROMPT_PRINTER) and modular procedures for efficient reusability and readability.
Optimized Memory Use: Utilizes .DATA and .STACK segments efficiently for storing variables and intermediate results.
Requirements:
Emulator: Requires an 8086 emulator, such as EMU8086, to compile and run the code.
Assembly Language knowledge to modify and extend functionality.
This program is ideal for learning assembly language basics, understanding 8086 architecture, and exploring real-world applications of microprocessor programming.

Feel free to contribute and enhance the code by adding more features like advanced calculations or additional unit conversions!
