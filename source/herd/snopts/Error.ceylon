"An error that occurred during argument parsing."
shared abstract class Error()
        of FlagWithArgumentError | ParameterWithoutArgumentError | UnknownOptionError {
    "An error message, suitable for printing
     to the standard error stream."
    shared actual formal String string;
}

"A flag was given an argument."
shared class FlagWithArgumentError(flag, argument) extends Error() {
    
    "The flag."
    shared Flag flag;
    "The argument."
    shared String argument;
    
    string => "option '--``flag.name``' doesn't allow an argument";
}

"A parameter was not given an argument."
shared class ParameterWithoutArgumentError(parameter) extends Error() {
    
    "The parameter."
    shared Parameter parameter;
    
    string => "option '--``parameter.name``' requires an argument";
}

"An unknown option was given."
shared abstract class UnknownOptionError()
        of UnknownLongOptionError | UnknownShortOptionError
        extends Error() {}

"An unknown long option was given."
shared class UnknownLongOptionError(name) extends UnknownOptionError() {
    
    "The name of the unknown option."
    shared String name;
    
    string => "unknown option '--``name``'";
}

shared class UnknownShortOptionError(shortForm) extends UnknownOptionError() {
    
    "The shorthand form of the unknown option."
    shared Character shortForm;
    
    string => "unknown option '-``shortForm``'";
}
