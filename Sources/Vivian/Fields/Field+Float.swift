extension Float: _FloatFieldValue {}
extension Optional: _FloatFieldValue where Wrapped == Float {}

extension Field where Value: _FloatFieldValue {
    public init(
        _ keyPath: KeyPath<Model, Value>,
        defaultFactory: (FieldDefaultFactory<Value>)? = nil,
        ge: Float? = nil,
        le: Float? = nil,
        gt: Float? = nil,
        lt: Float? = nil,
        multipleOf: Float? = nil,
        allowInfiniteAndNaN: Bool = false,
        default defaultValue: Value? = nil,
        validateDefault: ValidateDefault? = nil,
        strict: Bool = false,
        before: BeforeValidator? = nil,
        after: AfterValidator<Float>? = nil
    ) {
        let schema = FloatSchema(
            strict: strict,
            lt: lt,
            le: le,
            gt: gt,
            ge: ge,
            multipleOf: multipleOf,
            allowInfiniteAndNaN: allowInfiniteAndNaN,
            beforeValidator: before,
            afterValidator: after,
            // defaultFactory: defaultFactory,
            // defaultValue: defaultValue,
            // validateDefault: validateDefault
        )
        self.init(keyPath, schema: schema)
        // print("Field<Float>")
        // print("  keyPath : \(keyPath)")
        // print("  ge      : \(ge as Any)")
        // print("  le      : \(le as Any)")
    }
}
