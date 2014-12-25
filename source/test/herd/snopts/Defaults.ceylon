import herd.snopts {
    Defaults,
    Flag,
    Parameter
}
import ceylon.test {
    test,
    assertEquals,
    assertNull
}

shared abstract class DefaultsTest() {
    
    shared Flag politeFlag = Flag("polite");
    shared Flag floodFlag = Flag("flood");
    shared Parameter serverParameter = Parameter("server");
    shared Parameter portParameter = Parameter("port");
    shared Flag helpFlag = Flag("help");
    shared Parameter verboseParameter = Parameter("verbose");

    test
    shared void testDefaults() {
        assertEquals {
            expected = true;
            actual = defaults.flag(politeFlag);
        };
        assertEquals {
            expected = false;
            actual = defaults.flag(floodFlag);
        };
        assertEquals {
            expected = "localhost";
            actual = defaults.parameter(serverParameter);
        };
        assertEquals {
            expected = "80";
            actual = defaults.parameter(portParameter);
        };
        assertNull(defaults.flag(helpFlag));
        assertNull(defaults.parameter(verboseParameter));
    }
    
    "The defaults to be tested.
     
     The following values should be defined,
     and only those:
     
     - [[politeFlag]]: [[true]]
     - [[floodFlag]]: [[false]]
     - [[serverParameter]]: `localhost`
     - [[portParameter]]: `80`"
    shared formal Defaults defaults;
}
