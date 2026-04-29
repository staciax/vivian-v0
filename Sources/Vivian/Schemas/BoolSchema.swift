public struct BoolSchema: Schema {
    public typealias Output = Bool

    public let type = "bool"
    public var strict: Bool

    public var beforeValidator: BeforeValidator? = nil
    public var afterValidator: AfterValidator<Output>? = nil

    init(
        strict: Bool = false,
        beforeValidator: BeforeValidator? = nil,
        afterValidator: AfterValidator<Output>? = nil
    ) {
        self.strict = strict
        self.beforeValidator = beforeValidator
        self.afterValidator = afterValidator
    }

    public func makeValidator() -> any Validator {
        return BoolValidator(strict: strict)
    }

}
