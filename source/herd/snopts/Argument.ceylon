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
