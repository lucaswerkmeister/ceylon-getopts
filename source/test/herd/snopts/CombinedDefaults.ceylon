import herd.snopts {
    CombinedDefaults,
    StreamDefaults
}

shared class CombinedDefaultsTests() extends DefaultsTest() {
    defaults => CombinedDefaults {
        StreamDefaults {
            politeFlag->true
        },
        StreamDefaults {
            floodFlag->false
        },
        StreamDefaults {
            serverParameter->"localhost"
        },
        StreamDefaults {
            portParameter->"80"
        }
    };
}
