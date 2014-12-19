import herd.snopts {
    StreamDefaults,
    Flag,
    Parameter
}
import ceylon.test {
    test,
    assertEquals,
    assertNull
}

test
shared void streamDefaults() {
    value politeFlag = Flag("polite");
    value portParameter = Parameter("port");
    value verboseParameter = Parameter("verbose");
    StreamDefaults defaults = StreamDefaults {
        politeFlag->true,
        portParameter->"80"
    };
    assertEquals {
        expected = true;
        actual = defaults.flag(politeFlag);
    };
    assertEquals {
        expected = "80";
        actual = defaults.parameter(portParameter);
    };
    assertNull(defaults.parameter(verboseParameter));
}
