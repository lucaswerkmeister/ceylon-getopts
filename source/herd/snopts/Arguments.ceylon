"The parsed input to a program: Its [[arguments]],
 along with the [[errors]] that occurred while
 parsing the arguments."
shared class Arguments(arguments, errors) {
    
    "The arguments to the program."
    shared Argument[] arguments;
    "Errors that occurred during parsing the [[arguments]]."
    shared Error[] errors;
}
