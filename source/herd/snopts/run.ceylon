import ceylon.collection {
    LinkedList
}

// PART 1: Option definitions

shared abstract class Option(name, shortForm)
        of Flag | Parameter {
    shared String name;
    shared Character? shortForm;
}

shared class Flag(String name, Character? shortForm = null)
        extends Option(name, shortForm) {}

shared class Parameter(String name, Character? shortForm = null)
        extends Option(name, shortForm) {}

shared Option[] parseOptions(String[] input) {
    value options = LinkedList<Option>();
    for (line in input) {
        Option(String, Character?) constructor;
        String shortAndLong;
        if (line.startsWith("*")) {
            constructor = Parameter;
            shortAndLong = line[1...];
        } else {
            constructor = Flag;
            shortAndLong = line;
        }
        String name;
        Character? shortForm;
        switch (shortAndLong.firstIndexWhere(':'.equals))
        case (0) {
            // extension: support options without short form as ‘:long-name’
            shortForm = null;
            name = shortAndLong[1...];
        }
        case (1) {
            shortForm = shortAndLong[0];
            name = shortAndLong[2...];
        }
        case (null) {
            // extension: support options without short form as ‘long-name’
            shortForm = null;
            name = shortAndLong;
        }
        else {
            throw AssertionError("Flag must not be longer than one character");
        }
        options.add(constructor(name, shortForm));
    }
    return options.sequence();
}

// PART 2: Argument parsing

shared abstract class Argument()
        of FlagArgument | ParameterArgument | FreeArgument {}

shared class FlagArgument(shared Flag flag) extends Argument() {
    string => "flag: ``flag.name``";
}
shared class ParameterArgument(shared Parameter parameter, shared String argument) extends Argument() {
    string => "flag: ``parameter.name`` (value: ``argument``)";
}
shared class FreeArgument(shared String argument) extends Argument() {
    string => "parameter: ``argument``";
}

Argument[] parseArguments(Option[] options, String[] input) {
    value arguments = LinkedList<Argument>();
    variable Integer i = 0;
    while (exists argument = input[i]) {
        i++;
        if (argument.startsWith("-")) {
            if (argument.startsWith("--")) {
                value nameAndArg = argument[2...];
                if (nameAndArg.empty) {
                    // extension: -- terminates options, everything that follows is free arguments even if it starts with hyphens
                    arguments.addAll(input[i...].map(FreeArgument));
                    break;
                } else {
                    if (exists splitIndex = nameAndArg.firstIndexWhere('='.equals)) {
                        value name = nameAndArg[... splitIndex-1];
                        value arg = nameAndArg[splitIndex+1 ...];
                        assert (is Parameter option = options.find((Option option) => option.name == name));
                        arguments.add(ParameterArgument(option, arg));
                    } else {
                        value name = nameAndArg;
                        value option = options.find((Option option) => option.name == name);
                        switch (option)
                        case (is Flag) {
                            arguments.add(FlagArgument(option));
                        }
                        case (is Parameter) {
                            // extension: look in next argument, i. e. ‘--output log.txt’
                            if (exists arg = input[i], !arg.startsWith("-")) {
                                i++;
                                arguments.add(ParameterArgument(option, arg));
                            } else {
                                throw AssertionError("Missing argument for parameter ‘``option.name``’");
                            }
                        }
                        case (null) {
                            arguments.add(FlagArgument(Flag(name)));
                        }
                    }
                }
            } else {
                value flags = argument[1...];
                for (char in flags.reversed.rest.reversed) {
                    assert (is Flag flag = options.find((Option option) => (option.shortForm else '\{NULL}') == char));
                    arguments.add(FlagArgument(flag));
                }
                assert (exists lastChar = flags.last);
                assert (exists option = options.find((Option option) => (option.shortForm else '\{NULL}') == lastChar));
                switch (option)
                case (is Flag) {
                    arguments.add(FlagArgument(option));
                }
                case (is Parameter) {
                    assert (exists arg = input[i]);
                    i++;
                    arguments.add(ParameterArgument(option, arg));
                }
            }
        } else {
            arguments.add(FreeArgument(argument));
        }
    }
    return arguments.sequence();
}

// PART 3: CLI interface

shared void run() {
    assert (exists firstLine = process.readLine(),
        exists n = parseInteger(firstLine));
    value lines = LinkedList<String>();
    for (i in 0:n) {
        assert (exists line = process.readLine());
        lines.add(line);
    }
    value options = parseOptions(lines.sequence());
    assert (exists argumentsLine = process.readLine());
    value arguments = parseArguments(options, argumentsLine.split().sequence());
    print("\n".join(arguments));
}

