extension Int: _IntFieldValue {}
extension Optional: _IntFieldValue where Wrapped == Int {}

extension Field where Value: _IntFieldValue {
    public init(
        _ keyPath: KeyPath<Model, Value>,
        defaultFactory: (FieldDefaultFactory<Value>)? = nil,
        ge: Int? = nil,
        le: Int? = nil,
        gt: Int? = nil,
        lt: Int? = nil,
        multipleOf: Int? = nil,
        default defaultValue: Value? = nil,
        validateDefault: ValidateDefault? = nil,
        strict: Bool = false,
        before: BeforeValidator? = nil,
        after: AfterValidator<Int>? = nil
    ) {
        let schema = IntSchema(
            strict: strict,
            ge: ge,
            le: le,
            gt: gt,
            lt: lt,
            multipleOf: multipleOf,
            beforeValidator: before,
            afterValidator: after,
            // defaultFactory: defaultFactory,
            // defaultValue: defaultValue,
            // validateDefault: validateDefault
        )
        self.init(keyPath, schema: schema)
        // print("Field<Int>")
        // print("  keyPath    : \(keyPath)")
        // print("  ge         : \(ge as Any)")
        // print("  le         : \(le as Any)")
        // print("  gt         : \(gt as Any)")
        // print("  lt         : \(lt as Any)")
        // print("  multipleOf : \(multipleOf as Any)")
        // print("  default    : \(defaultValue as Any)")
    }
}
