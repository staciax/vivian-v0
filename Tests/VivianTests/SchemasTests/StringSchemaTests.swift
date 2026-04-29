import Testing

@testable import Vivian

@Test(arguments: ["ayo", "stacia", "x", "nodoka"])
func testStringSchema(_ value: String) throws {
    var state = ValidationState(config: Config.default)

    let schema = StringSchema()
    let result = try schema.validate(value, state: &state)

    #expect(result == value)
}
