public typealias FieldDefaultFactory<Value: Sendable> = @Sendable () throws -> Value
public typealias SchemaModel = Codable & Sendable

public enum ValidateDefault: Sendable {
    case enabled
}
