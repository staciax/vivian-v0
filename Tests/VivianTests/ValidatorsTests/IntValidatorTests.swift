import Testing

@testable import Vivian

@Test(arguments: [-2, -1, 0, 1, 2, 4, 6, 8] as [Int])
func testIntValidator(_ value: Int) throws {
    var state = ValidationState(config: .default)
    let validator = IntValidator(strict: true)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: [10, 15, 20] as [Int])
func testConstrainedIntValidator(_ value: Int) throws {
    var state = ValidationState(config: .default)
    let validator = ConstrainedIntValidator(strict: true, le: 20, ge: 10)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}
