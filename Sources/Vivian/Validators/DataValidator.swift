import Foundation

public struct DataValidator: Validator {
    let strict: Bool

    public init(strict: Bool = false) {
        self.strict = strict
    }

    public var name: String { "data" }
    public typealias Output = Data

    public func validate(_ input: AnyInput, state: inout ValidationState) throws(ValidationError) -> Output {
        if let data = input.asInstance(of: Data.self) {
            return data
        }

        guard !state.strictOr(strict) else {
            throw ValidationError.dataType
        }

        // TODO: maybe from string with base64 encoding?

        throw ValidationError.dataType
    }
}
