public typealias BeforeValidator = @Sendable (any Sendable) -> any Sendable
public typealias AfterValidator<Output: Sendable> = @Sendable (Output) -> Output

public protocol Schema: Sendable {
    associatedtype Output: Sendable

    func makeValidator() -> any Validator

    var beforeValidator: BeforeValidator? { get }
    var afterValidator: AfterValidator<Output>? { get }

    func validate(_ input: any Sendable, state: inout ValidationState) throws -> Output
}

extension Schema {

    @discardableResult
    public func validate(
        _ input: any Sendable,
        state: inout ValidationState
    ) throws -> Output {
        var raw = input

        if let before = beforeValidator {
            raw = before(raw)
        }

        let anyinput = AnyInput(raw)

        let validator = makeValidator()

        var validated = try validator.validate(anyinput, state: &state) as! Output
        if let after = afterValidator {
            validated = after(validated)
        }
        return validated
    }
}
