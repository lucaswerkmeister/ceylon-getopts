"Applies [[defaults]] to some [[arguments]].
 
 This is not really intended for external use;
 it’s just one part of the option processing pipeline."
shared [Arguments,Error[]] applyDefaults(Defaults defaults, Argument[] arguments, Error[] errors)
        => [Arguments(arguments, defaults), errors];
