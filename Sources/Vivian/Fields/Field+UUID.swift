import Foundation

extension UUID: _UUIDFieldValue {}
extension Optional: _UUIDFieldValue where Wrapped == UUID {}

extension Field where Value: _UUIDFieldValue {
    public init(
        _ keyPath: KeyPath<Model, Value>,
        defaultFactory: (FieldDefaultFactory<Value>)? = nil,
        version: UUIDVersion? = nil,
        default defaultValue: Value? = nil,
        validateDefault: ValidateDefault? = nil,
        strict: Bool = false,
        before: BeforeValidator? = nil,
        after: AfterValidator<UUID>? = nil
    ) {
        let schema = UUIDSchema(
            strict: strict,
            version: version?.rawValue,
            beforeValidator: before,
            afterValidator: after,
            // defaultFactory: defaultFactory,
            // defaultValue: defaultValue,
            // validateDefault: validateDefault
        )
        self.init(keyPath, schema: schema)
        // print("Field<UUID>")
        // print("  keyPath : \(keyPath)")
        // print("  version : \(version as Any)")
        // print("  factory : \(defaultFactory as Any)")
    }
}
