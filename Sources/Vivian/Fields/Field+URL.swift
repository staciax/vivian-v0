import Foundation

extension URL: _URLFieldValue {}
extension Optional: _URLFieldValue where Wrapped == URL {}

public enum URLFormat: Sendable {
    case any
    case anyHttp
    case http
    case anyWebsocket
    case websocket
    case file
    case ftp

    case custom(UrlConstraints)

    var constraints: UrlConstraints {
        switch self {
        case .any: return UrlConstraints()
        case .anyHttp: return UrlConstraints(allowedSchemes: ["http", "https"])
        case .http: return UrlConstraints(allowedSchemes: ["http", "https"], maxLength: 2083)
        case .anyWebsocket: return UrlConstraints(allowedSchemes: ["ws", "wss"])
        case .websocket: return UrlConstraints(allowedSchemes: ["ws", "wss"], maxLength: 2083)
        case .file: return UrlConstraints(allowedSchemes: ["file"])
        case .ftp: return UrlConstraints(allowedSchemes: ["ftp"])
        case .custom(let constraints): return constraints
        // case .redis: return UrlConstraints(allowedSchemes: ["redis", "rediss"], defaultHost: "localhost", defaultPort: 6379)
        // case .postgres: return UrlConstraints(allowedSchemes: ["postgres", "postgresql"], hostRequired: true)
        }
    }
}

extension Field where Value: _URLFieldValue {
    public init(
        _ keyPath: KeyPath<Model, Value>,
        defaultFactory: (FieldDefaultFactory<Value>)? = nil,
        format: URLFormat? = nil,
        default defaultValue: Value? = nil,
        validateDefault: ValidateDefault? = nil,
        strict: Bool = false,
        before: BeforeValidator? = nil,
        after: AfterValidator<URL>? = nil
    ) {
        let schema = URLSchema(
            strict: strict,
            constraints: format?.constraints,
            beforeValidator: before,
            afterValidator: after,
            // defaultFactory: defaultFactory,
            // defaultValue: defaultValue,
            // validateDefault: validateDefault
        )
        self.init(keyPath, schema: schema)
        // print("Field<URL>")
        // print("  keyPath : \(keyPath)")
        // print("  format  : \(format as Any)")
        // print("  default : \(defaultValue as Any)")
    }
}
