import Testing

@testable import Vivian

@Test(arguments: [0.0, 1.23, -4.56] as [Float])
func testFloatValidator(_ value: Float) throws {
    var state = ValidationState(config: .default)
    let validator = FloatValidator(strict: true)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: [Float.nan, Float.infinity])
func testFloatValidatorFiniteness(_ value: Float) throws {
    var state = ValidationState(config: .default)
    let validator = FloatValidator(strict: true, allowInfiniteAndNaN: false)

    let input = AnyInput(value)
    #expect(throws: ValidationError.self) {
        try validator.validate(input, state: &state)
    }
}
