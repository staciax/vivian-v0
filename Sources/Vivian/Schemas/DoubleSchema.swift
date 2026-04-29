public struct DoubleSchema: Schema {
    public typealias Output = Double

    public let strict: Bool
    public let lt: Double?
    public let le: Double?
    public let gt: Double?
    public let ge: Double?
    public let multipleOf: Double?
    public let allowInfiniteAndNaN: Bool

    public var beforeValidator: BeforeValidator? = nil
    public var afterValidator: AfterValidator<Output>? = nil

    public init(
        strict: Bool = false,
        lt: Double? = nil,
        le: Double? = nil,
        gt: Double? = nil,
        ge: Double? = nil,
        multipleOf: Double? = nil,
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
            return DoubleValidator(strict: strict)
        }
        return ConstrainedDoubleValidator(
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
