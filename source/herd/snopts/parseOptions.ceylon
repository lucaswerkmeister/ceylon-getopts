import ceylon.collection {
    LinkedList
}

shared Option[] parseOptions(String[] input) {
    value options = LinkedList<Option>();
    for (line in input) {
        Option(String, Character?) constructor;
        String shortAndLong;
        if (line.startsWith("*")) {
            constructor = Parameter;
            shortAndLong = line[1...];
        } else {
            constructor = Flag;
            shortAndLong = line;
        }
        String name;
        Character? shortForm;
        switch (shortAndLong.firstIndexWhere(':'.equals))
        case (0) {
            // extension: support options without short form as ‘:long-name’
            shortForm = null;
            name = shortAndLong[1...];
        }
        case (1) {
            shortForm = shortAndLong[0];
            name = shortAndLong[2...];
        }
        case (null) {
            // extension: support options without short form as ‘long-name’
            shortForm = null;
            name = shortAndLong;
        }
        else {
            throw AssertionError("Flag must not be longer than one character");
        }
        options.add(constructor(name, shortForm));
    }
    return options.sequence();
}
