public struct IntSchema: Schema {
    public typealias Output = Int
    public let type = "int"

    public var strict: Bool
    public var ge: Int?
    public var le: Int?
    public var gt: Int?
    public var lt: Int?
    public var multipleOf: Int?

    public var beforeValidator: BeforeValidator? = nil
    public var afterValidator: AfterValidator<Output>? = nil

    public init(
        strict: Bool = false,
        ge: Int? = nil,
        le: Int? = nil,
        gt: Int? = nil,
        lt: Int? = nil,
        multipleOf: Int? = nil,
        beforeValidator: BeforeValidator? = nil,
        afterValidator: AfterValidator<Output>? = nil
    ) {
        self.strict = strict
        self.ge = ge
        self.le = le
        self.gt = gt
        self.lt = lt
        self.multipleOf = multipleOf
        self.beforeValidator = beforeValidator
        self.afterValidator = afterValidator
    }

    public func makeValidator() -> any Validator {
        guard ge != nil || le != nil || gt != nil || lt != nil || multipleOf != nil else {
            return IntValidator(strict: strict)
        }
        return ConstrainedIntValidator(
            strict: strict,
            lt: lt,
            le: le,
            gt: gt,
            ge: ge,
            multipleOf: multipleOf
        )
    }

}
