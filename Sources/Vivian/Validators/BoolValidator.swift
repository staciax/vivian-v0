public struct BoolValidator {
    public let strict: Bool

    public init(strict: Bool) {
        self.strict = strict
    }
}

extension BoolValidator: Validator {
    public var name: String { "bool" }
    public typealias Output = Bool

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        let value = try input.validateBool(strict: strict).resolved(into: &state)
        return value
    }
}
