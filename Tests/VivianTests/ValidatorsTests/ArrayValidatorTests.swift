import Testing

@testable import Vivian

@Test(arguments: [[1, 2, 3], [0], [-1, -2]])
func testArrayIntValidator(_ value: [Int]) throws {
    var state = ValidationState(config: .default)
    let validator = ArrayValidator<IntValidator>(strict: true, itemValidator: IntValidator(strict: true))

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: [[1]])
func testArrayIntValidatorMinLength(_ value: [Int]) throws {
    var state = ValidationState(config: .default)
    let validator = ArrayValidator<IntValidator>(
        strict: true,
        itemValidator: IntValidator(strict: true),
        minLength: 2
    )

    let input = AnyInput(value)
    #expect(throws: ValidationError.self) {
        try validator.validate(input, state: &state)
    }
}

@Test(arguments: [[1, 2, 3]])
func testArrayIntValidatorMaxLength(_ value: [Int]) throws {
    var state = ValidationState(config: .default)
    let validator = ArrayValidator<IntValidator>(
        strict: true,
        itemValidator: IntValidator(strict: true),
        maxLength: 2
    )

    let input = AnyInput(value)
    #expect(throws: ValidationError.self) {
        try validator.validate(input, state: &state)
    }
}
