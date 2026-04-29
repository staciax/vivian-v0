extension ObjectSchema {
    public init(
        @TypedSchemaBuilder<Model> _ build: () throws -> [any AnyField<Model>]
    ) throws {
        self.fields = try build()
    }

    public init(
        @TypedSchemaBuilder<Model> _ build: () -> [any AnyField<Model>]
    ) {
        self.fields = build()
    }
}

// public struct CollectionFieldAdapter<C: Collection & (Codable & Sendable)>: AnyField
// where C.Element: Codable & Sendable {
//     public typealias Model = C
//     public typealias Value = C.Element

//     public let propertyName: String
//     public let schema: any Schema

//     public let element: any AnyField<C.Element>

//     public init(_ element: any AnyField<C.Element>) {
//         self.element = element
//         self.propertyName = element.propertyName
//         self.schema = element.schema
//     }

//     public var anyKeyPath: PartialKeyPath<Model> {
//         element.anyKeyPath as! PartialKeyPath<Model>
//     }

//     public var writableKeyPath: AnyKeyPath? {
//         element.writableKeyPath
//     }

//     // public func assign(to model: inout C.Element, value: Any) {
//     //     element.assign(to: &model, value: value)
//     // }

//     public func validate(model: inout C.Element) throws -> Value {
//         return try element.validate(model: &model) as! Value
//     }
// }

// extension ObjectSchema
// where
//     Model: Collection,
//     Model.Element: Codable & Sendable
// {
//     public init(
//         @TypedSchemaBuilder<Model.Element> _ build: () -> [any AnyField<Model.Element>]
//     ) {
//         self.fields = build().map { CollectionFieldAdapter($0) }
//     }
// }
