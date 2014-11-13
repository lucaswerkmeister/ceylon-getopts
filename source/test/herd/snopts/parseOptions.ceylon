import herd.snopts {
    parseOptions,
    Flag,
    Parameter
}
import ceylon.test {
    test,
    assertEquals
}

shared class ParseOptions() {
    
    test
    shared void noOptions() {
        assertEquals {
            expected = [];
            actual = parseOptions([]);
            message = "No options";
        };
    }
    
    test
    shared void flags() {
        assertEquals {
            expected = [
                Flag("help", 'h'),
                Flag("verbose", 'v'),
                Flag("version", 'V')
            ];
            actual = parseOptions([
                    "h:help",
                    "v:verbose",
                    "V:version"
                ]);
            message = "Regular flags";
        };
    }
    
    test
    shared void parameters() {
        assertEquals {
            expected = [
                Parameter("size", 's'),
                Parameter("user", 'u'),
                Parameter("max-count", 'n')
            ];
            actual = parseOptions([
                    "*s:size",
                    "*u:user",
                    "*n:max-count"
                ]);
            message = "Parameters";
        };
    }
    
    test
    shared void noShortForm1() {
        assertEquals {
            expected = [
                Flag("stdin", null),
                Parameter("exclude", null)
            ];
            actual = parseOptions([
                    ":stdin",
                    "*:exclude"
                ]);
            message = "Extension: No short form, with colon";
        };
    }
    
    test
    shared void noShortForm2() {
        assertEquals {
            expected = [
                Flag("stdin", null),
                Parameter("exclude", null)
            ];
            actual = parseOptions([
                    "stdin",
                    "*exclude"
                ]);
            message = "Extension: No short form, without colon";
        };
    }
    
    test
    shared void combined() {
        assertEquals {
            expected = [
                Flag("help", 'h'),
                Flag("version", null),
                Flag("verbose", 'v'),
                Parameter("count", 'n'),
                Parameter("no-default-repositories", null)
            ];
            actual = parseOptions([
                    "h:help",
                    ":version",
                    "v:verbose",
                    "*n:count",
                    "*no-default-repositories"
                ]);
            message = "Combined full test";
        };
    }
}
