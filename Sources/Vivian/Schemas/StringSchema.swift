public struct StringSchema: Schema, @unchecked Sendable {
    public typealias Output = String

    public let type = "str"
    public var strict: Bool
    public var minLength: Int?
    public var maxLength: Int?
    public var pattern: Regex<String>?
    public var trim: Bool
    public var toLowercase: Bool
    public var toUppercase: Bool
    public let coerceNumbersToString: Bool

    public var beforeValidator: BeforeValidator? = nil
    public var afterValidator: AfterValidator<Output>? = nil

    public init(
        strict: Bool = false,
        minLength: Int? = nil,
        maxLength: Int? = nil,
        pattern: Regex<String>? = nil,
        trim: Bool = false,
        toLowercase: Bool = false,
        toUppercase: Bool = false,
        coerceNumbersToString: Bool = false,
        beforeValidator: BeforeValidator? = nil,
        afterValidator: AfterValidator<Output>? = nil
    ) {
        precondition(!(toLowercase && toUppercase), "Cannot set both toLower and toUpper to true")
        self.strict = strict
        self.minLength = minLength
        self.maxLength = maxLength
        self.pattern = pattern
        self.trim = trim
        self.toLowercase = toLowercase
        self.toUppercase = toUppercase
        self.coerceNumbersToString = coerceNumbersToString
        self.beforeValidator = beforeValidator
        self.afterValidator = afterValidator
    }

    public func makeValidator() -> any Validator {
        guard
            maxLength != nil || minLength != nil
                || trim
                || pattern != nil
                || toLowercase || toUppercase
                || coerceNumbersToString
        else {
            return StringValidator(strict: strict, coerceNumbersToString: coerceNumbersToString)
        }

        let pattern: Pattern<String>? =
            if let regex = self.pattern {
                Pattern(regex)
            } else {
                nil
            }

        return StringConstrainedValidator<String>(
            strict: strict,
            pattern: pattern,
            minLength: minLength,
            maxLength: maxLength,
            trim: trim,
            toLowercase: toLowercase,
            toUppercase: toUppercase,
            coerceNumbersToString: coerceNumbersToString
        )
    }

}
