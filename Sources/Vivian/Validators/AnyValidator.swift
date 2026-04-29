public struct AnyValidator {
    public init() {}
}

extension AnyValidator: Validator {
    public var name: String { "any" }
    public typealias Output = any Sendable

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        return input
    }
}
