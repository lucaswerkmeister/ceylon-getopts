import herd.snopts {
    parseBoolish
}
import ceylon.test {
    test,
    assertTrue,
    assertFalse,
    assertNull
}

test
shared void testParseBoolish() {
    for (trueish in { "true", "yes", "on" }) {
        assertTrue(parseBoolish(trueish) else false);
    }
    for (falseish in { "false", "no", "off" }) {
        assertFalse(parseBoolish(falseish) else true);
    }
    for (unboolish in { "maybe", "eh", "dunno", "I don’t want to participate in this survey", "'; DROP DATABASE; --" }) {
        assertNull(parseBoolish(unboolish));
    }
}
