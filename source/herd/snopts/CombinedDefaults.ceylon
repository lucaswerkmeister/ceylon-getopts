"A combination of several defaults.
 
 Each [[flag]] and [[parameter]] is searched
 in the [[defaults]] in order."
shared class CombinedDefaults(defaults) satisfies Defaults {
    
    shared {Defaults*} defaults;
    
    shared actual Boolean? flag(Flag flag)
            => { for (default in defaults) if (exists f = default.flag(flag)) f }.first;
    
    shared actual String? parameter(Parameter parameter)
            => { for (default in defaults) if (exists p = default.parameter(parameter)) p }.first;
}
