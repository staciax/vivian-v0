import Testing

@testable import Vivian

@Test(arguments: [0, 1, true, false] as [any Sendable])
func testBoolSchema(_ value: any Sendable) throws {
    var state = ValidationState(config: Config.default)

    let schema = BoolSchema()
    try schema.validate(value, state: &state)
}
