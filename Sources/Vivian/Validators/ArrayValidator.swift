public struct ArrayValidator<V: Validator>: Validator {
    public let strict: Bool
    public let itemValidator: (any Validator)?
    public let minLength: Int?
    public let maxLength: Int?
    // public let name: String?
    public let failFast: Bool

    public init(
        strict: Bool,
        itemValidator: (any Validator)? = nil,
        minLength: Int? = nil,
        maxLength: Int? = nil,
        failFast: Bool = false
    ) {
        self.strict = strict
        self.itemValidator = itemValidator
        self.minLength = minLength
        self.maxLength = maxLength
        // self.name = name
        self.failFast = failFast
    }

    public var name: String { "array" }
    public typealias Output = [V.Output]

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        let items = try input.validateArray(strict: strict).resolved(into: &state)

        guard let itemValidator else {
            return items as! [V.Output]
        }

        var output: [V.Output] = []
        var errors: [any Error] = []

        // pre-allocate output array capacity
        // if possible to improve performance
        output.reserveCapacity(items.count)

        for item in items {
            do {
                let validated = try itemValidator.validate(item, state: &state)
                output.append(validated as! V.Output)

                if let maxLength, output.count > maxLength {
                    throw ValidationError.tooLong(
                        fieldType: "Array",
                        maxLength: maxLength,
                        actualLength: items.count
                    )
                }
            } catch let error as ValidationError {
                errors.append(error)
                if failFast { break }
            }
        }

        // if !errors.isEmpty {
        //     throw ValidationError.something(errors)
        // }

        if let minLength, output.count < minLength {
            throw ValidationError.tooShort(
                fieldType: "Array", minLength: minLength, actualLength: output.count
            )
        }

        if let maxLength, output.count > maxLength {
            throw ValidationError.tooLong(
                fieldType: "Array", maxLength: maxLength, actualLength: output.count
            )
        }

        return output
    }
}
