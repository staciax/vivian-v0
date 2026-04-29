import Testing

@testable import Vivian

@Test(arguments: [1, 2, 3, 4, 5, 6])
func testIntSchema(_ value: Int) throws {
    var state = ValidationState(config: Config.default)

    let schema = IntSchema()
    let result = try schema.validate(value, state: &state)

    #expect(result == value)
}
