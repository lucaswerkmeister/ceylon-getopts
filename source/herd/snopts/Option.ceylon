shared abstract class Option(name, shortForm)
        of Flag | Parameter {
    shared String name;
    shared Character? shortForm;
}

shared class Flag(String name, Character? shortForm = null)
        extends Option(name, shortForm) {}

shared class Parameter(String name, Character? shortForm = null)
        extends Option(name, shortForm) {}
