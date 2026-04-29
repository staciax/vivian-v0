public protocol AnyField<Model>: Sendable where Model: SchemaModel {
    associatedtype Model
    associatedtype Value
    var propertyName: String { get }
    var schema: any Schema { get }

    var anyKeyPath: PartialKeyPath<Model> { get }
    var writableKeyPath: AnyKeyPath? { get }
    var referenceKeyPath: AnyKeyPath? { get }

    func assign(to model: inout Model, value: Any)

    func validate(
        model: Model,
        config: Config,
    ) throws -> Value
}

// extension AnyField {
//     func validate(model: Model, state: inout ValidationState) throws {
//         let value = model[keyPath: keyPath]
//         let input = AnyInput(value)
//         _ = try schema.validate(input, state: &state)
//     }
// }
