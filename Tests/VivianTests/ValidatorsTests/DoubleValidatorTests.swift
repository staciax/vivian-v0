import Testing

@testable import Vivian

@Test(arguments: [0.0, 3.14, -2.718] as [Double])
func testDoubleValidator(_ value: Double) throws {
    var state = ValidationState(config: .default)
    let validator = DoubleValidator(strict: true)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: [Double.nan, Double.infinity])
func testDoubleValidatorFiniteness(_ value: Double) throws {
    var state = ValidationState(config: .default)
    let validator = DoubleValidator(strict: true, allowInfiniteAndNaN: false)

    let input = AnyInput(value)
    #expect(throws: ValidationError.self) {
        try validator.validate(input, state: &state)
    }
}
