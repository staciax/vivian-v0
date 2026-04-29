public struct TupleValidator {
    public let strict: Bool
    public let validators: [any Validator]
    public let variadicItemIndex: Int?
    public let minLength: Int?
    public let maxLength: Int?
    public let failFast: Bool
    // public let name: String

    public init(
        strict: Bool,
        validators: [any Validator],
        variadicItemIndex: Int? = nil,
        minLength: Int? = nil,
        maxLength: Int? = nil,
        failFast: Bool = false
    ) {
        self.strict = strict
        self.validators = validators
        self.variadicItemIndex = variadicItemIndex
        self.minLength = minLength
        self.maxLength = maxLength
        self.failFast = failFast
    }
}

extension TupleValidator: Validator {
    public var name: String { "tuple" }
    public typealias Output = [any Sendable]

    public func validate(_ input: AnyInput, state: inout ValidationState) throws(ValidationError) -> Output {
        // let strict = state.strictOr(self.strict)
        throw ValidationError.tupleType
    }
}
