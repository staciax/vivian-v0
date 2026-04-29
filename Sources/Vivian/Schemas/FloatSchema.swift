public struct FloatSchema: Schema {
    public typealias Output = Float

    public let type = "float"

    public let strict: Bool
    public let lt: Float?
    public let le: Float?
    public let gt: Float?
    public let ge: Float?
    public let multipleOf: Float?
    public let allowInfiniteAndNaN: Bool

    public var beforeValidator: BeforeValidator? = nil
    public var afterValidator: AfterValidator<Output>? = nil

    public init(
        strict: Bool = false,
        lt: Float? = nil,
        le: Float? = nil,
        gt: Float? = nil,
        ge: Float? = nil,
        multipleOf: Float? = nil,
        allowInfiniteAndNaN: Bool = false,
        beforeValidator: BeforeValidator? = nil,
        afterValidator: AfterValidator<Output>? = nil
    ) {
        self.strict = strict
        self.lt = lt
        self.le = le
        self.gt = gt
        self.ge = ge
        self.multipleOf = multipleOf
        self.allowInfiniteAndNaN = allowInfiniteAndNaN
        self.beforeValidator = beforeValidator
        self.afterValidator = afterValidator
    }

    public func makeValidator() -> any Validator {
        guard
            ge != nil || le != nil
                || gt != nil || lt != nil
                || multipleOf != nil
                || allowInfiniteAndNaN
        else {
            return FloatValidator(strict: strict)
        }
        return ConstrainedFloatValidator(
            strict: strict,
            lt: lt,
            le: le,
            gt: gt,
            ge: ge,
            multipleOf: multipleOf,
            allowInfiniteAndNaN: allowInfiniteAndNaN
        )
    }

}
