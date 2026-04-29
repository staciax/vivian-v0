import Foundation

extension Bool: _BoolFieldValue {}
extension Optional: _BoolFieldValue where Wrapped == Bool {}

extension Field where Value: _BoolFieldValue {
    public init(
        _ keyPath: KeyPath<Model, Value>,
        defaultFactory: (FieldDefaultFactory<Value>)? = nil,
        default defaultValue: Value? = nil,
        validateDefault: ValidateDefault? = nil,
        strict: Bool = false,
        before: BeforeValidator? = nil,
        after: AfterValidator<Bool>? = nil
    ) {
        let schema = BoolSchema(
            strict: strict,
            beforeValidator: before,
            afterValidator: after,
            // defaultFactory: defaultFactory,
            // defaultValue: defaultValue,
            // validateDefault: validateDefault
        )
        self.init(keyPath, schema: schema)
        // print("Field<Bool>")
        // print("  keyPath : \(keyPath)")
        // print("  format  : \(format as Any)")
        // print("  default : \(defaultValue as Any)")
    }
}
