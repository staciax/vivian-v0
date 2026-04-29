import Testing

@testable import Vivian

@Test(arguments: [10.5, 15.1, 20, 5.3, 9.0, 11.8])
func testFloatSchema(_ value: Float) throws {
    var state = ValidationState(config: Config.default)

    let schema = FloatSchema()
    let result = try schema.validate(value, state: &state)

    #expect(result == value)
}
