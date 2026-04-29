import Foundation
import Testing

@testable import Vivian

@Test(arguments: [Date(), Date(timeIntervalSince1970: 0)])
func testDateValidator(_ value: Date) throws {
    var state = ValidationState(config: .default)
    let validator = DateValidator(strict: true)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: ["2026-04-14T00:00:00Z", "2026-04-15T12:00:00Z"])
func testDateValidatorISO8601(_ value: String) throws {
    var state = ValidationState(config: .default)
    let validator = DateValidator(strict: false)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    let formatter = ISO8601DateFormatter()
    let expectedValue = formatter.date(from: value)
    #expect(result == expectedValue)
}
