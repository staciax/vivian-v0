import Foundation
import Testing

@testable import Vivian

@Test(arguments: [UUID(), UUID()])
func testUUIDValidator(_ value: UUID) throws {
    var state = ValidationState(config: .default)
    let validator = UUIDValidator(strict: true)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: [UUID(), UUID()])
func testUUIDValidatorString(_ value: UUID) throws {
    var state = ValidationState(config: .default)
    let validator = UUIDValidator(strict: false)

    let input = AnyInput(value.uuidString)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}
