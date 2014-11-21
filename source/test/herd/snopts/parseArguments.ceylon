import herd.snopts {
    parseArguments,
    Flag,
    Parameter,
    Argument,
    FlagArgument,
    ParameterArgument,
    FreeArgument
}
import ceylon.test {
    test,
    assertEquals
}

shared class ParseArguments() {
    
    value helpFlag = Flag("help", 'h');
    value verboseFlag = Flag("verbose", 'v');
    value versionFlag = Flag("version", 'V');
    value sizeParameter = Parameter("size", 's');
    value userParameter = Parameter("user", 'u');
    value maxCountParameter = Parameter("max-count", 'n');
    value options = [helpFlag, verboseFlag, versionFlag, sizeParameter, userParameter, maxCountParameter];
    
    void doTest(Argument[] expected, String[] arguments) {
        assertEquals {
            expected = expected;
            actual = parseArguments(options, arguments).arguments;
            message = " ".join(arguments);
        };
    }
    
    test
    shared void noArguments() {
        doTest([], []);
    }
    
    test
    shared void longFlags() {
        doTest {
            expected = [
                FlagArgument(helpFlag),
                FlagArgument(versionFlag),
                FlagArgument(verboseFlag)
            ];
            arguments = [
                "--``helpFlag.name``",
                "--``versionFlag.name``",
                "--``verboseFlag.name``"
            ];
        };
    }
    
    test
    shared void shortIndividualFlags() {
        doTest {
            expected = [
                FlagArgument(helpFlag),
                FlagArgument(versionFlag),
                FlagArgument(verboseFlag)
            ];
            arguments = [
                "-" + (helpFlag.shortForm?.string else ""),
                "-" + (versionFlag.shortForm?.string else ""),
                "-" + (verboseFlag.shortForm?.string else "")
            ];
        };
    }
    
    test
    shared void shortCollapsedFlags() {
        doTest {
            expected = [
                FlagArgument(helpFlag),
                FlagArgument(versionFlag),
                FlagArgument(verboseFlag)
            ];
            arguments = [
                "-"
                        + (helpFlag.shortForm?.string else "")
                        + (versionFlag.shortForm?.string else "")
                        + (verboseFlag.shortForm?.string else "")];
        };
    }
    
    test
    shared void freeArguments() {
        doTest {
            expected = [
                FreeArgument("Hello"),
                FreeArgument("World")
            ];
            arguments = [
                "Hello",
                "World"
            ];
        };
    }
    
    test
    shared void parametersWithEquals() {
        doTest {
            expected = [
                ParameterArgument(sizeParameter, "50G"),
                ParameterArgument(userParameter, "lucas"),
                ParameterArgument(maxCountParameter, "42")
            ];
            arguments = [
                "--``sizeParameter.name``=50G",
                "--``userParameter.name``=lucas",
                "--``maxCountParameter.name``=42"
            ];
        };
    }
    
    test
    shared void parametersWithoutEquals() {
        doTest {
            expected = [
                ParameterArgument(sizeParameter, "50G"),
                ParameterArgument(userParameter, "lucas"),
                ParameterArgument(maxCountParameter, "42")
            ];
            arguments = [
                "--``sizeParameter.name``", "50G",
                "--``userParameter.name``", "lucas",
                "--``maxCountParameter.name``", "42"
            ];
        };
    }
    
    test
    shared void shortParameters() {
        doTest {
            expected = [
                ParameterArgument(sizeParameter, "50G"),
                ParameterArgument(userParameter, "lucas"),
                ParameterArgument(maxCountParameter, "42")
            ];
            arguments = [
                "-" + (sizeParameter.shortForm?.string else ""), "50G",
                "-" + (userParameter.shortForm?.string else ""), "lucas",
                "-" + (maxCountParameter.shortForm?.string else ""), "42"
            ];
        };
    }
    
    test
    shared void shortParametersGroup() {
        doTest {
            expected = [
                FlagArgument(verboseFlag),
                ParameterArgument(maxCountParameter, "42")
            ];
            arguments = [
                "-" + (verboseFlag.shortForm?.string else "") + (maxCountParameter.shortForm?.string else "") + "42"
            ];
        };
    }
    
    test
    shared void combined() {
        doTest {
            expected = [
                FlagArgument(helpFlag),
                ParameterArgument(sizeParameter, "50G"),
                FlagArgument(versionFlag),
                ParameterArgument(userParameter, "lucas"),
                FreeArgument("Hello"),
                FlagArgument(verboseFlag),
                ParameterArgument(maxCountParameter, "42"),
                FreeArgument("World"),
                FreeArgument("--help"),
                FreeArgument("-rwx")
            ];
            arguments = [
                "-" + (helpFlag.shortForm?.string else "") + (sizeParameter.shortForm?.string else ""), "50G",
                "--``versionFlag.name``",
                "--``userParameter.name``", "lucas",
                "Hello",
                "-" + (verboseFlag.shortForm?.string else "") + (maxCountParameter.shortForm?.string else ""), "42",
                "World",
                "--",
                "--help",
                "-rwx"
            ];
        };
    }
}
