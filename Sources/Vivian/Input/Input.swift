public enum Exactness: Sendable {
    case exact, strict, lax
}

public struct ValidationMatch<T: Sendable>: Sendable {
    public let value: T
    public let exactness: Exactness

    public static func exact(_ value: T) -> Self { .init(value: value, exactness: .exact) }
    public static func strict(_ value: T) -> Self { .init(value: value, exactness: .strict) }
    public static func lax(_ value: T) -> Self { .init(value: value, exactness: .lax) }

    public func requireExact() -> T? {
        exactness == .exact ? value : nil
    }

    @discardableResult
    public func resolved(into state: inout ValidationState) -> T {
        state.floorExactness(exactness)
        return value
    }
}

public protocol Input: Sendable {
    associatedtype Value: Sendable
    var value: Value { get }
    var isNil: Bool { get }

    func validateString(strict: Bool, coerceNumbersToString: Bool) throws(ValidationError) -> ValidationMatch<String>
    func validateBool(strict: Bool) throws(ValidationError) -> ValidationMatch<Bool>
    func validateInt(strict: Bool) throws(ValidationError) -> ValidationMatch<Int>
    func validateFloat(strict: Bool) throws(ValidationError) -> ValidationMatch<Float>
    func validateDouble(strict: Bool) throws(ValidationError) -> ValidationMatch<Double>
    func validateCharacter(strict: Bool) throws(ValidationError) -> ValidationMatch<Character>
    func validateArray(strict: Bool) throws(ValidationError) -> ValidationMatch<[AnyInput]>

    func asInstance<T>(of type: T.Type) -> T?
}

extension Input {
    public var isNil: Bool { false }

    public func asInstance<T>(of type: T.Type) -> T? {
        value as? T
    }
}
