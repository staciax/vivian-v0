public struct UnionValidator: Validator {
    public let choices: [any Validator]

    public var name: String { "union" }
    public typealias Output = any Sendable

    public func validate(_ input: AnyInput, state: inout ValidationState) throws(ValidationError) -> Output {
        fatalError("TODO: implement union validator")
    }
}
