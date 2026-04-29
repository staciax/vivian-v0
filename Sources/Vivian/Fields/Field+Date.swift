import Foundation

extension Date: _DateFieldValue {}
extension Optional: _DateFieldValue where Wrapped == Date {}

public enum DateFormat: Sendable {
    case iso8601
    case custom(String)
}

extension Field where Value: _DateFieldValue {
    public init(
        _ keyPath: KeyPath<Model, Value>,
        defaultFactory: (FieldDefaultFactory<Value>)? = nil,
        format: DateFormat? = nil,
        default defaultValue: Value? = nil,
        validateDefault: ValidateDefault? = nil,
        strict: Bool = false,
        before: BeforeValidator? = nil,
        after: AfterValidator<Date>? = nil
    ) {
        let schema = DateSchema(
            strict: strict,
            beforeValidator: before,
            afterValidator: after,
            // format: format,
            // defaultFactory: defaultFactory,
            // defaultValue: defaultValue,
            // validateDefault: validateDefault
        )
        self.init(keyPath, schema: schema)
        // print("Field<Date>")
        // print("  keyPath : \(keyPath)")
        // print("  format  : \(format as Any)")
        // print("  default : \(defaultValue as Any)")
    }
}
