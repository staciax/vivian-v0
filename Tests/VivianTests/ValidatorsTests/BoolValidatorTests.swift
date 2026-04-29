import Testing

@testable import Vivian

@Test(arguments: [true, false])
func testBoolValidator(_ value: Bool) throws {
    var state = ValidationState(config: .default)
    let validator = BoolValidator(strict: true)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: [
    (1, true),
    (0, false),
])
func testBoolValidatorCoercionInt(_ input: Int, expected: Bool) throws {
    var state = ValidationState(config: .default)
    let validator = BoolValidator(strict: false)

    let inputWrapper = AnyInput(input)
    let result = try validator.validate(inputWrapper, state: &state)

    #expect(result == expected)
}

@Test(arguments: [
    (1.0, true),
    (0.0, false),
])
func testBoolValidatorCoercionDouble(_ input: Double, expected: Bool) throws {
    var state = ValidationState(config: .default)
    let validator = BoolValidator(strict: false)

    let inputWrapper = AnyInput(input)
    let result = try validator.validate(inputWrapper, state: &state)

    #expect(result == expected)
}

@Test(arguments: [
    ("true", true),
    ("yes", true),
    ("1", true),
    ("false", false),
    ("no", false),
    ("0", false),
])
func testBoolValidatorCoercionString(_ input: String, expected: Bool) throws {
    var state = ValidationState(config: .default)
    let validator = BoolValidator(strict: false)

    let inputWrapper = AnyInput(input)
    let result = try validator.validate(inputWrapper, state: &state)

    #expect(result == expected)
}
