import Testing

@testable import Vivian

@Test(arguments: ["ayo", 42, true] as [any Sendable])
func testAnyValidator(_ value: any Sendable) throws {
    var state = ValidationState(config: .default)
    let validator = AnyValidator()

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    let output = result as? AnyInput
    #expect(String(describing: output!.value!) == String(describing: value))
}
