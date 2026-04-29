import Testing

@testable import Vivian

@Test(arguments: [nil as Int?, nil as String?] as [(any Sendable)?])
func testNilValidator(_ value: (any Sendable)?) throws {
    var state = ValidationState(config: .default)
    let validator = NilValidator()

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == true)
}

@Test(arguments: [42, "not nil", true] as [any Sendable])
func testNilValidatorNotNil(_ value: any Sendable) throws {
    var state = ValidationState(config: .default)
    let validator = NilValidator()

    let input = AnyInput(value)
    #expect(throws: ValidationError.self) {
        try validator.validate(input, state: &state)
    }
}
