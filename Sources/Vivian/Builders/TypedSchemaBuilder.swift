@resultBuilder
public struct TypedSchemaBuilder<Model: SchemaModel> {
    public static func buildExpression<V: _FieldValue>(
        _ field: Field<Model, V>
    ) -> [any AnyField<Model>] {
        [field]
    }

    public static func buildBlock(
        _ components: [any AnyField<Model>]...
    ) -> [any AnyField<Model>] {
        components.flatMap { $0 }
    }
}
