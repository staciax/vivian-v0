extension Double: _DoubleFieldValue {}
extension Optional: _DoubleFieldValue where Wrapped == Double {}

extension Field where Value: _DoubleFieldValue {
    public init(
        _ keyPath: KeyPath<Model, Value>,
        defaultFactory: (FieldDefaultFactory<Value>)? = nil,
        ge: Double? = nil,
        le: Double? = nil,
        gt: Double? = nil,
        lt: Double? = nil,
        multipleOf: Double? = nil,
        allowInfiniteAndNaN: Bool = false,
        default defaultValue: Value? = nil,
        validateDefault: ValidateDefault? = nil,
        strict: Bool = false,
        before: BeforeValidator? = nil,
        after: AfterValidator<Double>? = nil
    ) {
        let schema = DoubleSchema(
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
        // print("Field<Double>")
        // print("  keyPath          : \(keyPath)")
        // print("  ge               : \(ge as Any)")
        // print("  le               : \(le as Any)")
        // print("  allowInfiniteNaN : \(allowInfiniteAndNaN)")
    }
}
