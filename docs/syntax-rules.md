# zson Syntax Rules

This document defines the syntax rules for parsing `zson` files. `zson` is an extended version of JSON, similar to Jsonnet, and it allows the inclusion of additional functionality such as conditionals, functions, and variable assignments while still producing a valid JSON output. This document will serve as the specification for how `.zson` files should be processed by your parser.

## Basic Structure

### Variables and Assignment

zson allows variable assignments using the = operator, similar to many programming languages. Variables are scoped to the file or the block in which they are defined.

    Variable Assignment: The assignment can occur within an object, at the top level, or inside functions/blocks.

Example:

```
let x = 10;
let y = x + 5;
```

Evaluation: When zson files are evaluated, variables are substituted with their assigned values. They can be used in expressions or within object keys/values.

Example:

```
{
    "result": x + y // result will be 15
}
```

### Expressions and Operators

zson supports expressions with arithmetic operators (+, -, *, /, %), comparison operators (==, !=, <, >, <=, >=), and logical operators (&&, ||).

#### Arithmetic and Comparison:
    
```
let sum = 10 + 20;
let is_equal = x == y;
```

#### Logical Expressions

```
let is_valid = x > 10 && y < 20;
```

#### Conditionals

zson supports basic conditional expressions using if and else.

```
let status = if x > 10 then "Greater" else "Smaller";
```

#### Functions

zson supports function definitions using the fn keyword. Functions can be defined to return a value based on parameters.

    Function Definition: Example:

    fn add(a, b) {
        return a + b;
    }

    let result = add(5, 10); // result will be 15

    Function Calls: Functions can be called with arguments just like in typical programming languages.

#### Blocks and Let Statements

Blocks are used to group expressions together. You can define a block for logic, or to execute multiple statements sequentially. Inside a block, variables can be defined using the let keyword.

```
let x = 10;
let y = 20;
{
    let z = x + y;
    z // result will be 30
}
```

#### Imports and Includes

zson allows you to include other `.zson` files using the `import` keyword. This helps to modularize the code.

```
import "./path/to/module.zson";
```

#### Special zson Syntax for Top-Level Expressions

Some top-level expressions are specific to zson and do not directly map to JSON. These need to be processed as metadata or logic during parsing.

Top-Level Expressions: These expressions will be processed first and then translated into their corresponding JSON equivalent.


```
let version = 1.0;
let config = {
    "name": "config",
    "version": version
};
```

In this example, the let declarations are part of the parsing process and are substituted into the final output.

#### Error Handling

zson supports basic error handling for operations or function calls using the catch keyword. The catch block will capture errors during evaluation and prevent the program from crashing.

```
try {
    // Code that might throw an error
    let result = some_function_that_might_fail();
} catch |e| {
    // Handle the error
    e // return the error
}
```

#### Other Constructs

These are constructs that help with processing zson files.

    Comments: Comments can be added using // for single-line comments, and /* */ for multi-line comments. These are ignored during parsing and do not affect the output.

```
// This is a comment

/* This is a 
    multi-line
    comment */
```

#### Final JSON Output

Once the .zson file is fully parsed and processed, the final result is output as a valid JSON file. This involves:

    Substituting any variables with their assigned values.
    Evaluating all expressions, functions, and conditionals.
    Flattening any blocks or top-level expressions into the final structure.

For example, a `.zson` file:

```
let x = 10;
let y = x + 5;

{
    "x_value": x,
    "y_value": y,
    "is_valid": x > 5
}
```

Will produce the following JSON:

```
{
    "x_value": 10,
    "y_value": 15,
    "is_valid": true
}
```

Summary of zson-Specific Syntax
Syntax Element	Description

| Syntax                     | Description                                                                              | Example                                                |
| -------------------------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| `let`                      | Defines a variable with a value.                                                         | `let name = "Alice";`                                  |
| `fn`                       | Defines a function with parameters and a return value.                                   | `fn greeting(user) { return "Hello, " + user + "!"; }` |
| `if ... then ... else ...` | Conditional expression to assign values based on a condition.                            | `let status = if age >= 18 then "Adult" else "Minor";` |
| `//`                       | Single-line comment.                                                                     | `// This is a comment.`                                |
| `{ ... }`                  | Defines an object structure.                                                             | `{ "key": value, "key2": anotherValue }`               |
| `+`                        | Concatenation operator for strings.                                                      | `let greeting = "Hello, " + name + "!";`               |
| Expressions                | Inline calculations or evaluations used for dynamic value assignment.                    | `let sum = x + y;`                                     |
| Function Calls             | Calls a defined function with arguments.                                                 | `let message = greeting(name);`                        |
| JSON Compatibility         | Supports JSON-compatible syntax alongside `zson` extensions.                             | `{ "key": "value", "num": 42 }`                        |
| Multiline Objects          | Objects and arrays can span multiple lines for readability.                              | `{ "key": "value", "nested": { "inner": 42 } }`        |
| Unquoted Keys              | Object keys can be written without quotes if they are valid identifiers (ZSON-specific). | `{ key: "value", anotherKey: 42 }`                     |


This document provides the syntax rules for processing .zson files. These rules define how variables, expressions, conditionals, functions, and other constructs should be parsed and evaluated, ultimately generating a valid JSON output.

By following these rules, you can build a parser that transforms zson syntax into JSON while supporting the rich functionality that sets zson apart from plain JSON.