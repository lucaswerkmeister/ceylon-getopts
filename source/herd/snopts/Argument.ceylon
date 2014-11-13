"A single argument that the program received."
shared abstract class Argument()
        of FlagArgument | ParameterArgument | FreeArgument {}

"A flag argument, indicating the presence of a [[flag]]."
shared class FlagArgument(flag) extends Argument() {
    
    "The flag."
    shared Flag flag;
    
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
    
    string => "flag: ``parameter.name`` (value: ``argument``)";
}

"A free argument, not bound to any [[Option]]."
shared class FreeArgument(argument) extends Argument() {
    
    "The argument."
    shared String argument;
    
    string => "parameter: ``argument``";
}
