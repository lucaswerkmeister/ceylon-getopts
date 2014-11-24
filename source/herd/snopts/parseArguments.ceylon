import ceylon.collection {
    LinkedList
}

shared Arguments parseArguments(Option[] options, String[] input) {
    value arguments = LinkedList<Argument>();
    value errors = LinkedList<Error>();
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
                        value name = nameAndArg[... splitIndex - 1];
                        value arg = nameAndArg[splitIndex + 1 ...];
                        value option = options.find((Option option) => option.name == name);
                        switch (option)
                        case (is Parameter) { arguments.add(ParameterArgument(option, arg)); }
                        case (is Flag) {
                            if (exists boolish = parseBoolish(arg)) {
                                arguments.add(FlagArgument(option, boolish)); // --flag=true, --flag=off, etc.
                            } else {
                                errors.add(FlagWithArgumentError(option, arg));
                            }
                        }
                        case (null) { errors.add(UnknownLongOptionError(name)); }
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
                                errors.add(ParameterWithoutArgumentError(option));
                            }
                        }
                        case (null) {
                            arguments.add(FlagArgument(Flag(name)));
                        }
                    }
                }
            } else {
                variable String shortForms = argument;
                while (exists shortForm = shortForms.first) {
                    shortForms = shortForms[1...];
                    value option = options.find((Option option) => (option.shortForm else '\{NULL}') == shortForm);
                    switch (option)
                    case (is Flag) { arguments.add(FlagArgument(option)); }
                    case (is Parameter) {
                        if (!shortForms.empty) {
                            // use rest of short forms as argument, e. g. `-xyzn10`
                            arguments.add(ParameterArgument(option, shortForms));
                        } else {
                            // attempt to use next argument as argument, e. g. `-xyzn 10`
                            if (exists arg = input[i]) {
                                i++;
                                arguments.add(ParameterArgument(option, arg));
                            } else {
                                errors.add(ParameterWithoutArgumentError(option));
                            }
                        }
                        break;
                    }
                    case (null) { errors.add(UnknownShortOptionError(shortForm)); }
                }
            }
        } else {
            arguments.add(FreeArgument(argument));
        }
    }
    return Arguments(arguments.sequence(), errors.sequence());
}
