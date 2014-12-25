import herd.snopts {
    StreamDefaults
}

shared class StreamDefaultsTests() extends DefaultsTest() {
    defaults => StreamDefaults {
        politeFlag->true,
        floodFlag->false,
        serverParameter->"localhost",
        portParameter->"80"
    };
}
