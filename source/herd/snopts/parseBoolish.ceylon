"Parses a boolean-like value.
 
 Recognized values include:
 - [[true]]:
   - `true`
   - `yes`
   - `on`
 - [[false]]:
   - `false`
   - `no`
   - `off`
 
 For unrecognized values, [[null]] is returned."
// TODO l10n? i16n?
shared Boolean? parseBoolish(String boolish) {
    switch (boolish)
    case ("true" | "yes" | "on") { return true; }
    case ("false" | "no" | "off") { return false; }
    else { return null; }
}
