import Testing

@testable import Vivian

@Test(arguments: ["s", "t", "a", "c", "i", "a", " ", "a", "y", "o"] as [Character])
func testCharacterValidator(_ value: Character) throws {
    var state = ValidationState(config: .default)
    let validator = CharacterValidator(strict: true)

    let input = AnyInput(value)
    let result = try validator.validate(input, state: &state)

    #expect(result == value)
}

@Test(arguments: [
    ("N", "n" as Character),
    ("D", "d" as Character),
    ("K", "k" as Character),
])
func testConstrainedCharacterValidatorLowercase(_ input: String, expected: Character) throws {
    var state = ValidationState(config: .default)
    let validator = ConstrainedCharacterValidator(strict: true, toLowercase: true)

    let inputWrapper = AnyInput(input)
    let result = try validator.validate(inputWrapper, state: &state)

    #expect(result == expected)
}
