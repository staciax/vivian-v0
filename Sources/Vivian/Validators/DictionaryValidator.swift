public struct DictionaryValidator<K: Validator, V: Validator>: Validator where K.Output: Hashable {

    public let strict: Bool
    public let keyValidator: (any Validator)?
    public let valueValidator: (any Validator)?
    public let minLength: Int?
    public let maxLength: Int?
    public let failFast: Bool
    // public let name: String

    public init(
        strict: Bool,
        keyValidator: (any Validator)? = nil,
        valueValidator: (any Validator)? = nil,
        minLength: Int? = nil,
        maxLength: Int? = nil,
        failFast: Bool = false
    ) {
        self.strict = strict
        self.keyValidator = keyValidator
        self.valueValidator = valueValidator
        self.minLength = minLength
        self.maxLength = maxLength
        self.failFast = failFast
    }

    public var name: String { "dictionary" }
    public typealias Output = [K.Output: V.Output]

    public func validate(_ input: AnyInput, state: inout ValidationState) throws(ValidationError) -> Output {
        // let strict = state.strictOr(self.strict)
        throw ValidationError.dictType
    }
}
