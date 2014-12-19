"""An implementation of [[Defaults]]
   that reads a stream of default arguments.
   
   Usage example:
   
       Defaults defaults = StreamDefaults {
           politeFlag->true,
           portParameter->"80",
           verboseParameter->"warn"
       };"""
shared class StreamDefaults(defaults) satisfies Defaults {
    
    shared {<Parameter->String>|<Flag->Boolean>*} defaults;
    
    shared actual Boolean? flag(Flag flag) {
        if (exists default = defaults.find((default) => flag == default.key)) {
            assert (is Boolean b = default.item);
            return b;
        } else {
            return null;
        }
    }
    
    shared actual String? parameter(Parameter parameter) {
        if (exists default = defaults.find((default) => parameter == default.key)) {
            assert (is String s = default.item);
            return s;
        } else {
            return null;
        }
    }
}
