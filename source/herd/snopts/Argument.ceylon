"A single argument that the program received."
shared abstract class Argument()
        of FlagArgument | ParameterArgument | FreeArgument {
    
    "The option to which this argument is bound,
     or [[null]] if this is a [[free argument|FreeArgument]]."
    shared formal Option? option;
    
    "The value of this argument."
    shared formal String|Boolean argument;
}

"A flag argument, indicating the presence of a [[flag]].
 
 Usually, the flag was specified without an explicit argument,
 in which case the [[perceived argument|argument]] is [[true]].
 However, it is also possible to explicitly disable flags,
 resulting in a [[false]] [[argument]]."
shared class FlagArgument(flag, argument = true) extends Argument() {
    
    "The flag."
    shared Flag flag;
    option => flag;
    
    "The boolean argument ([[true]] by default)."
    shared actual Boolean argument;
    
    shared actual Boolean equals(Object other) {
        if (is FlagArgument other) {
            return flag == other.flag && argument == other.argument;
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
    option => parameter;
    
    "The argument to the parameter."
    shared actual String argument;
    
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
    
    option => null;
    
    "The argument."
    shared actual String argument;
    
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
