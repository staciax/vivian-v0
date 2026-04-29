extension PartialKeyPath {
    var fieldName: String {
        let desc = String(describing: self)

        // note: string splitting (17-04-2026)
        // i suddenly noticed split creates an array, so it probably allocates
        // tested it, and yeah it does
        // so i tried a different approach: find the last "." and slice from there
        // simpler and avoids unnecessary allocation
        //
        // desc.split(separator: ".").last.map(String.init) ?? desc
        //
        // and it also helped me appreciate Substring more
        // since it's just a slice sharing the same storage
        // with no allocation unless converted to String
        //
        // benchmark: https://gist.github.com/staciax/967b6c3314c5e0764d4fcf513a3015f7

        return desc.lastIndex(of: ".").map {
            String(desc[desc.index(after: $0)...])
        } ?? desc
    }
}

public struct Field<Model: SchemaModel, Value: _FieldValue>: AnyField, @unchecked Sendable {
    public let keyPath: KeyPath<Model, Value>
    public let writableKeyPath: AnyKeyPath?
    public let referenceKeyPath: AnyKeyPath?

    public let propertyName: String
    public let schema: any Schema

    // let nestedFields: [any AnyField<Value>]?

    package init(
        _ keyPath: KeyPath<Model, Value>,
        schema: any Schema,
    ) {
        self.keyPath = keyPath
        self.writableKeyPath = keyPath as? WritableKeyPath<Model, Value>
        self.referenceKeyPath = keyPath as? ReferenceWritableKeyPath<Model, Value>
        self.propertyName = keyPath.fieldName
        self.schema = schema
    }

    public var anyKeyPath: PartialKeyPath<Model> {
        keyPath
    }

    public func assign(to model: inout Model, value: Any) {
        if let writableKeyPath = writableKeyPath as? WritableKeyPath<Model, Value> {
            model[keyPath: writableKeyPath] = value as! Value
        } else {
            fatalError("Attempting to assign to a read-only field '\(propertyName)'")
        }
    }

    public func validate(
        model: Model,
        config: Config,
    ) throws -> Value {
        var state = ValidationState(config: config)

        let raw: any Sendable = model[keyPath: keyPath]
        let value = try schema.validate(raw, state: &state) as! Value

        return value
    }

}
