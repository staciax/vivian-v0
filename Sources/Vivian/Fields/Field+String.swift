extension String: _StringFieldValue {}
extension Optional: _StringFieldValue where Wrapped == String {}

public enum StringFormat: Sendable {
    case email
    case nameEmail
}

extension Field where Value: _StringFieldValue {
    public init(
        _ keyPath: KeyPath<Model, Value>,
        defaultFactory: (FieldDefaultFactory<Value>)? = nil,
        format: StringFormat? = nil,
        minLength: Int? = nil,
        maxLength: Int? = nil,
        pattern: Regex<String>? = nil,
        trim: Bool = false,
        toLowercase: Bool = false,
        toUppercase: Bool = false,
        coerceNumbersToString: Bool = false,
        default defaultValue: Value? = nil,
        validateDefault: ValidateDefault? = nil,
        strict: Bool = false,
        before: BeforeValidator? = nil,
        after: AfterValidator<String>? = nil
    ) {
        // TODO: format, pattern maybe conflict??
        let schema = StringSchema(
            strict: strict,
            minLength: minLength,
            maxLength: maxLength,
            pattern: pattern,
            trim: trim,
            toLowercase: toLowercase,
            toUppercase: toUppercase,
            coerceNumbersToString: coerceNumbersToString,
            beforeValidator: before,
            afterValidator: after,
            // format: format,
            // defaultFactory: defaultFactory,
            // defaultValue: defaultValue,
            // validateDefault: validateDefault
        )
        self.init(keyPath, schema: schema)
        // print("Field<String>")
        // print("  keyPath: \(keyPath)")
        // print("  format: \(format as Any)")
        // print("  default: \(defaultValue as Any)")
    }
}
