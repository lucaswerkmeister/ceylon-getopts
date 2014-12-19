"A collection of arguments.
 
 The application should have one global `Arguments` value
 from which various routines may obtain [[parameters|parameter]],
 [[flags|flag]] and [[free arguments|freeArguments]]
 without having to bother with default arguments directly."
shared class Arguments(arguments, defaults) {
    
    shared Argument[] arguments;
    
    shared Defaults defaults;

    "Returns all arguments that have been given for this option."
    shared Argument[] get(Option option)
            => arguments.select {
            Boolean selecting(Argument argument) {
                if (exists argumentOption = argument.option) {
                    return argumentOption == option;
                } else {
                    return false;
                }
            }
        };
    
    "Returns the last argument for this flag,
     else its [[default value|defaults]],
     else [[false]]."
    shared Boolean flag(Flag flag) {
        if (exists lastFlagArgument = get(flag).last) {
            assert (is FlagArgument lastFlagArgument);
            return lastFlagArgument.argument;
        } else {
            return defaults.flag(flag) else false;
        }
    }
    
    "Returns the last argument for this parameter,
     else its [[default value|defaults]],
     else the empty string."
    shared String parameter(Parameter parameter) {
        if (exists lastParameterArgument = get(parameter).last) {
            assert (is ParameterArgument lastParameterArgument);
            return lastParameterArgument.argument;
        } else {
            return defaults.parameter(parameter) else "";
        }
    }
    
    shared String[] freeArguments
            => [for (argument in arguments) if (is FreeArgument argument) argument.argument];
}
