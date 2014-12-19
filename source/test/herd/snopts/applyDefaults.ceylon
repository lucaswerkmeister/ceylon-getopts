import herd.snopts {
    applyDefaults,
    StreamDefaults,
    Flag,
    Parameter,
    FlagArgument,
    ParameterArgument
}
import ceylon.test {
    test,
    assertEquals
}

shared class ApplyDefaults() {
    
    value politeFlag = Flag("polite");
    value portParameter = Parameter("port");
    value defaults = StreamDefaults {
        politeFlag->true,
        portParameter->"80"
    };
    
    test
    shared void givenFlag()
            => assertEquals {
        expected = false;
        actual = applyDefaults(defaults, [FlagArgument(politeFlag, false)], [])[0].flag(politeFlag);
    };
    
    test
    shared void givenParameter()
            => assertEquals {
        expected = "8080";
        actual = applyDefaults(defaults, [ParameterArgument(portParameter, "8080")], [])[0].parameter(portParameter);
    };
    
    test
    shared void absentFlag()
            => assertEquals {
        expected = true;
        actual = applyDefaults(defaults, [], [])[0].flag(politeFlag);
    };
    
    test
    shared void absentParameter()
            => assertEquals {
        expected = "80";
        actual = applyDefaults(defaults, [], [])[0].parameter(portParameter);
    };
}
