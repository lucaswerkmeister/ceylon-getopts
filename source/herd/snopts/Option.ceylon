Boolean nullsafeEquals(Anything a, Anything b) {
    if (exists a) {
        if (exists b) {
            return a == b;
        } else {
            return false;
        }
    } else {
        return !b exists;
    }
}

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
    
    shared actual Integer hash => name.hash + 31 * (shortForm?.hash else 0);
}

"A flag option, which can either be present or absent."
shared class Flag(String name, Character? shortForm = null)
        extends Option(name, shortForm) {
    
    shared actual Boolean equals(Object other) {
        if (is Flag other) {
            return name == other.name && nullsafeEquals(shortForm, other.shortForm);
        } else {
            return false;
        }
    }
    
    shared actual String string => "Flag(``name``, `` shortForm?.string else "null" ``)";
}

"A parameter option, which requires an argument."
shared class Parameter(String name, Character? shortForm = null)
        extends Option(name, shortForm) {
    
    shared actual Boolean equals(Object other) {
        if (is Parameter other) {
            return name == other.name && nullsafeEquals(shortForm, other.shortForm);
        } else {
            return false;
        }
    }
    
    shared actual String string => "Parameter(``name``, `` shortForm?.string else "null" ``)";
}
