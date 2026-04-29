import Foundation

public struct URLSchema: Schema {
    public typealias Output = URL

    public let type = "url"
    public var strict: Bool
    public var constraints: UrlConstraints?

    public var beforeValidator: BeforeValidator? = nil
    public var afterValidator: AfterValidator<Output>? = nil

    public init(
        strict: Bool = false,
        constraints: UrlConstraints? = nil,
        beforeValidator: BeforeValidator? = nil,
        afterValidator: AfterValidator<Output>? = nil
    ) {
        self.strict = strict
        self.constraints = constraints
        self.beforeValidator = beforeValidator
        self.afterValidator = afterValidator
    }

    public func makeValidator() -> any Validator {
        return URLValidator(strict: strict, constraints: constraints)
    }

    // public func validate(
    //     _ input: any Sendable,
    //     // state: ValidationState? = nil
    // ) throws -> Output {
    //     let config = Config()
    //     var state = ValidationState(config: config)

    //     let anyinput = AnyInput(input)
    //     let validator = makeValidator()
    //     let output = try validator.validate(anyinput, state: &state)
    //     return output as! Output
    // }
}
