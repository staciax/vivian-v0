import Foundation
import Testing

@testable import Vivian

@Test(arguments: ["stacia", "vivian", "nodoka"] as [String])
func testDataValidator(_ value: String) throws {
    var state = ValidationState(config: .default)
    let validator = DataValidator(strict: true)

    let data = value.data(using: .utf8)!
    let input = AnyInput(data)
    let result = try validator.validate(input, state: &state)

    #expect(result == data)
}
