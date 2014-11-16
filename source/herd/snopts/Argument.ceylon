"A single argument that the program received."
shared abstract class Argument()
        of FlagArgument | ParameterArgument | FreeArgument {}

"A flag argument, indicating the presence of a [[flag]]."
shared class FlagArgument(flag) extends Argument() {
    
    "The flag."
    shared Flag flag;
    
    shared actual Boolean equals(Object other) {
        if (is FlagArgument other) {
            return flag == other.flag;
        } else {
            return false;
        }
    }
    
    hash => 31 * flag.hash;
    
    string => "flag: ``flag.name``";
}

"A parameter argument, indicating the presence of a [[parameter]] with an [[argument]].
 
 The [[argument]] is simply a [[String]];
 any parsing (number, file path, URL, etc.) is left to the program."
shared class ParameterArgument(parameter, argument) extends Argument() {
    
    "The parameter."
    shared Parameter parameter;
    
    "The argument to the parameter."
    shared String argument;
    
    shared actual Boolean equals(Object other) {
        if (is ParameterArgument other) {
            return parameter == other.parameter
                    && argument == other.argument;
        } else {
            return false;
        }
    }
    
    hash => 31 * (parameter.hash + 31 * argument.hash);
    
    string => "flag: ``parameter.name`` (value: ``argument``)";
}

"A free argument, not bound to any [[Option]]."
shared class FreeArgument(argument) extends Argument() {
    
    "The argument."
    shared String argument;
    
    shared actual Boolean equals(Object other) {
        if (is FreeArgument other) {
            return argument == other.argument;
        } else {
            return false;
        }
    }
    
    hash => 31 * argument.hash;
    
    string => "parameter: ``argument``";
}
