"A single option that the program can accept."
shared abstract class Option(name, shortForm)
        of Flag | Parameter {
    
    "The full name of the option.
     
     Conventionally, this name is all lowercase,
     with words separated by hyphens, for example:
     ~~~
     help
     verbose
     with-dependencies
     names-only
     locale
     ~~~
     Note that the two hyphens typically associated with the full name
     (`--help`) are not part of the name itself."
    shared String name;
    
    "The shortcut form of the option,
     or [[null]] if the option can only be accessed
     by its [[long form|name]]."
    shared Character? shortForm;
}

"A flag option, which can either be present or absent."
shared class Flag(String name, Character? shortForm = null)
        extends Option(name, shortForm) {}

"A parameter option, which requires an argument."
shared class Parameter(String name, Character? shortForm = null)
        extends Option(name, shortForm) {}
