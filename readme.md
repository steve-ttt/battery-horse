

# Password Generator

This is a password generator written in Common Lisp. It generates passwords in the "correct-battery-horse-staple" style.

## Requirements

- SBCL (Steel Bank Common Lisp)
- Quicklisp
- UIOP (Utilities for Implementation- and OS- Portability)

## Usage

Compile the program with SBCL:

```bash
sbcl --load password-generator.lisp
(sb-ext:save-lisp-and-die "battery-horse.exe" :executable t :toplevel 'main)
```

Then, you can run the compiled program with command-line arguments:

```bash
./battery-horse.bin -n <number to generate> -min <min-word-count> -max <max-word-count> [-d </path/to/dictionary>]
```

## Command-Line Arguments

- `-n <number to generate>`: The number of passwords to generate.
- `-min <min-word-count>`: The minimum length of the words to use in the passwords.
- `-max <max-word-count>`: The maximum length of the words to use in the passwords.
- `-d </path/to/dictionary>`: (Optional) The path to a dictionary file to use for the words in the passwords. If not provided, it will use the default dictionary at `/usr/share/dict/words`.

## License

This project is licensed under the MIT License.

