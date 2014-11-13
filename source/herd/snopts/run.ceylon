import ceylon.collection {
    LinkedList
}

shared void run() {
    assert (exists firstLine = process.readLine(),
        exists n = parseInteger(firstLine));
    value lines = LinkedList<String>();
    for (i in 0:n) {
        assert (exists line = process.readLine());
        lines.add(line);
    }
    value options = parseOptions(lines.sequence());
    assert (exists argumentsLine = process.readLine());
    value arguments = parseArguments(options, argumentsLine.split().sequence());
    print("\n".join(arguments));
}
