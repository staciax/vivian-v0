public struct SetValidator<V: Validator>: Validator where V.Output: Hashable {
    public let strict: Bool
    public let itemValidator: (any Validator)?
    public let minLength: Int?
    public let maxLength: Int?
    public let failFast: Bool
    // public let name: String

    public init(
        strict: Bool = false,
        itemValidator: (any Validator)? = nil,
        minLength: Int? = nil,
        maxLength: Int? = nil,
        failFast: Bool = false
    ) {
        self.strict = strict
        self.itemValidator = itemValidator
        self.minLength = minLength
        self.maxLength = maxLength
        self.failFast = failFast
    }

    public var name: String { "set" }
    public typealias Output = [V.Output]

    public func validate(_ input: AnyInput, state: inout ValidationState) throws(ValidationError) -> Output {
        // let strict = state.strictOr(self.strict)
        throw ValidationError.setType
    }
}
