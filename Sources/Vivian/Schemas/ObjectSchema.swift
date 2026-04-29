import Foundation

public struct ObjectSchema<Model: Codable & Sendable>: Sendable {
    public let fields: [any AnyField<Model>]

    // public init(fields: [any AnyField<Model>]) {
    //     self.fields = fields
    // }

    @discardableResult
    public func validate(
        _ input: [AnyHashable: any Sendable],
        config: Config = .default,
    ) throws -> String {
        print(input)
        print(Model.self)

        return "Validated object with fields: \(fields.map { $0.propertyName }.joined(separator: ", "))"
    }

    @discardableResult
    public func validate(
        _ input: [any Sendable],
        config: Config = .default,
    ) throws -> String {
        print(input)
        print(Model.self)

        return "Validated object with fields: \(fields.map { $0.propertyName }.joined(separator: ", "))"
    }

    @discardableResult
    public func validate(
        _ input: Data,
        config: Config = .default,
        using decoder: JSONDecoder = .init()
    ) throws -> Model {

        // TODO: fix this later
        // convert Data to JSON.
        // validate each field.
        // cnvert JSON back to Data, then decode into Model.

        // var json = try JSONSerialization.jsonObject(with: input) as? [String: Any] ?? [:]
        // validate fields
        // let newJsonData = try JSONSerialization.data(withJSONObject: json)
        // let decoded = try decoder.decode(Model.self, from: newJsonData)

        let decoded = try decoder.decode(Model.self, from: input)
        var copyDecoded = decoded

        for field in fields {
            // let fieldName = field.propertyName
            // guard let value = json[fieldName] else {
            //     throw ValidationError.custom(message: "Missing required field '\(fieldName)'")
            // }

            let validated = try field.validate(model: copyDecoded, config: config)
            field.assign(to: &copyDecoded, value: validated)
        }

        return copyDecoded
    }
}

extension ObjectSchema {
    subscript(field: String) -> (any AnyField<Model>)? {
        return fields.first { $0.propertyName == field }
    }
}
