"An accessor for default arguments to
 parameter or flag options."
shared interface Defaults {
    
    "The default argument for this [[flag]],
     or [[null]] if there is no default argument."
    shared formal Boolean? flag(Flag flag);
    
    "The default argument for this [[parameter]],
     or [[null]] if there is no default parameter."
    shared formal String? parameter(Parameter parameter);
}
