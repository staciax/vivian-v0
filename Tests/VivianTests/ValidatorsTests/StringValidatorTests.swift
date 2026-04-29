import RegexBuilder
import Testing

@testable import Vivian

@Test(arguments: ["stacia", "nodoka", "vivian"])
func testStringValidator(_ value: String) throws {
    var state = ValidationState(config: Config.default)
    let validator = StringValidator(strict: true)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: ["stacia", "nodoka", "vivian"])
func testConstrainedStringMinLength(_ value: String) throws {
    var state = ValidationState(config: Config.default)
    let validator = StringConstrainedValidator<String>(strict: true, minLength: 6)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: [
    ("STACIA", "stacia"),
    ("NODOKA", "nodoka"),
    ("Vivian", "vivian"),
])
func testConstrainedStringLowercase(_ input: String, expected: String) throws {
    var state = ValidationState(config: Config.default)
    let validator = StringConstrainedValidator<String>(strict: true, toLowercase: true)

    let inputWrapper = AnyInput(input)
    let result = try validator.validate(inputWrapper, state: &state)

    #expect(result == expected)
}

@Test(arguments: [
    ("stacia", "STACIA"),
    ("nodoka", "NODOKA"),
    ("vivian", "VIVIAN"),
])
func testConstrainedStringUppercase(_ input: String, expected: String) throws {
    var state = ValidationState(config: Config.default)
    let validator = StringConstrainedValidator<String>(strict: true, toUppercase: true)

    let inputWrapper = AnyInput(input)
    let result = try validator.validate(inputWrapper, state: &state)

    #expect(result == expected)
}

@Test(arguments: [
    (123, "123"),
    (456, "456"),
    (789, "789"),
])
func testConstrainedStringCoercion(_ input: Int, expected: String) throws {
    var state = ValidationState(config: Config.default)
    let validator = StringValidator(strict: false, coerceNumbersToString: true)

    let inputWrapper = AnyInput(input)
    let result = try validator.validate(inputWrapper, state: &state)

    #expect(result == expected)
}
