import Foundation

public struct UUIDSchema: Schema {
    public typealias Output = UUID

    public let type = "uuid"
    public var strict: Bool
    public var version: UInt8?

    public var beforeValidator: BeforeValidator? = nil
    public var afterValidator: AfterValidator<Output>? = nil

    public init(
        strict: Bool = false,
        version: UInt8? = nil,
        beforeValidator: BeforeValidator? = nil,
        afterValidator: AfterValidator<Output>? = nil
    ) {
        self.strict = strict
        self.version = version
        self.beforeValidator = beforeValidator
        self.afterValidator = afterValidator
    }

    public func makeValidator() -> any Validator {
        return UUIDValidator(strict: strict, version: version)
    }

}
