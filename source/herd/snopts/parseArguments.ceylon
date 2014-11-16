import ceylon.collection {
    LinkedList
}

shared Argument[] parseArguments(Option[] options, String[] input) {
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
