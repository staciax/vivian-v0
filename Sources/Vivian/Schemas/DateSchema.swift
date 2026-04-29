import Foundation

public struct DateSchema: Schema {
    public typealias Output = Date

    public let type = "date"
    public var strict: Bool

    public var beforeValidator: BeforeValidator? = nil
    public var afterValidator: AfterValidator<Output>? = nil

    public init(
        strict: Bool = false,
        beforeValidator: BeforeValidator? = nil,
        afterValidator: AfterValidator<Output>? = nil
    ) {
        self.strict = strict
        self.beforeValidator = beforeValidator
        self.afterValidator = afterValidator
    }

    public func makeValidator() -> any Validator {
        return DateValidator(strict: strict)
    }
}
