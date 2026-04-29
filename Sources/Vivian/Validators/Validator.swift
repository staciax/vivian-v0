public protocol Validator: Sendable {
    associatedtype Output: Sendable
    var name: String { get }

    func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output
}
