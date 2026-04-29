public struct CharacterValidator {
    public let strict: Bool

    public init(strict: Bool = true) {
        self.strict = strict
    }
}

extension CharacterValidator: Validator {
    public var name: String { "char" }
    public typealias Output = Character

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        let value = try input.validateCharacter(strict: strict).resolved(into: &state)
        return value
    }
}

public struct ConstrainedCharacterValidator {
    public let strict: Bool
    public let toLowercase: Bool
    public let toUppercase: Bool
    // public let allowedCharacters: [Character]?

    init(
        strict: Bool = true,
        toLowercase: Bool = false,
        toUppercase: Bool = false
            // allowedCharacters: [Character]? = nil
    ) {
        precondition(!(toLowercase && toUppercase), "Cannot set both toLowercase and toUppercase to true")

        self.strict = strict
        self.toLowercase = toLowercase
        self.toUppercase = toUppercase
        // self.allowedCharacters = allowedCharacters
    }
}

extension ConstrainedCharacterValidator: Validator {
    public var name: String { "constrained-char" }
    public typealias Output = Character

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        var value = try input.validateCharacter(strict: strict).resolved(into: &state)

        if toLowercase {
            value = Character(value.lowercased())
        } else if toUppercase {
            value = Character(value.uppercased())
        }

        return value
    }
}
