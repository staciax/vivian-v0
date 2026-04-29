public struct NilValidator: Validator {
    public var name: String { "nil" }
    public typealias Output = Bool

    public func validate(_ input: AnyInput, state: inout ValidationState) throws(ValidationError) -> Output {
        guard input.isNil else {
            throw ValidationError.nilRequired
        }
        return true
    }
}
