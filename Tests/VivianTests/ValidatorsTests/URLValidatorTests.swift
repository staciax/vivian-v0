import Foundation
import Testing

@testable import Vivian

@Test(arguments: ["https://stacia.me", "https://nodoka.dev"])
func testURLValidatorString(_ value: String) throws {
    var state = ValidationState(config: .default)
    let validator = URLValidator(strict: false)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result.absoluteString == value)
}

@Test(arguments: [URL(string: "https://stacia.me")!, URL(string: "https://nodoka.dev")!])
func testURLValidator(_ value: URL) throws {
    var state = ValidationState(config: .default)
    let validator = URLValidator(strict: true)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}
