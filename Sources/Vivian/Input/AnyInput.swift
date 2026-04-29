import Foundation

public struct AnyInput: Input {
    public typealias Value = (any Sendable)?
    public let value: Value

    public init(_ value: Value) {
        self.value = value
    }

    public var isNil: Bool {
        value == nil
        // NOTE: value == nil, not support wrapped nil like AnyInput(Optional<Int>.none)
    }

    public func asInstance<T>(of type: T.Type) -> T? {
        (self as? T) ?? (value as? T)
    }

    public func validateString(
        strict: Bool, coerceNumbersToString: Bool
    ) throws(ValidationError) -> ValidationMatch<String> {
        if let v = value as? String { return .exact(v) }
        if let v = value as? Substring { return .strict(String(v)) }
        if let v = value as? Character { return .strict(String(v)) }

        guard !strict else {
            throw ValidationError.stringType
        }

        if let data = value as? Data {
            guard let utf8String = String(data: data, encoding: .utf8) else {
                throw ValidationError.stringUnicode
            }
            return .lax(utf8String)
        }

        if coerceNumbersToString {
            if let n = value as? Int { return .lax(String(n)) }
            if let n = value as? Double { return .lax(String(n)) }
            if let n = value as? Float { return .lax(String(n)) }
            if let n = value as? Decimal { return .lax(String(n.description)) }
        }

        throw ValidationError.stringType
    }

    public func validateBool(strict: Bool) throws(ValidationError) -> ValidationMatch<Bool> {
        if let v = value as? Bool { return .exact(v) }

        guard !strict else {
            throw ValidationError.boolType
        }
        if let v = value as? Int {
            switch v {
            case 0: return .lax(false)
            case 1: return .lax(true)
            default:
                throw ValidationError.boolParsing
            }
        }
        if let v = value as? Double {
            switch v {
            case 0: return .lax(false)
            case 1: return .lax(true)
            default:
                throw ValidationError.boolParsing
            }
        }
        if let v = value as? String {
            switch v.trimmingCharacters(in: .whitespaces).lowercased() {
            case "true", "yes", "1": return .lax(true)
            case "false", "no", "0": return .lax(false)
            default:
                throw ValidationError.boolParsing
            }
        }
        throw ValidationError.boolType
    }

    public func validateInt(strict: Bool) throws(ValidationError) -> ValidationMatch<Int> {
        if let v = value as? Int { return .exact(v) }
        if let v = value as? Bool {
            guard !strict else {
                throw ValidationError.intType
            }
            return .lax(v ? 1 : 0)
        }
        guard !strict else {
            throw ValidationError.intType
        }
        if let v = value as? Double {
            guard let i = Int(exactly: v) else {
                throw ValidationError.intFromFloat
            }
            return .lax(i)
        }
        if let v = value as? String {
            guard let i = Int(v) else {
                throw ValidationError.intParsing
            }
            return .lax(i)
        }
        throw ValidationError.intType
    }

    public func validateFloat(strict: Bool) throws(ValidationError) -> ValidationMatch<Float> {
        if let v = value as? Float { return .exact(v) }
        if let v = value as? Int { return .strict(Float(v)) }
        guard !strict else {
            throw ValidationError.floatType
        }
        if let v = value as? Bool { return .lax(v ? 1.0 : 0.0) }
        if let v = value as? String {
            guard let f = Float(v) else {
                throw ValidationError.floatParsing
            }
            return .lax(f)
        }
        throw ValidationError.floatType
    }

    public func validateDouble(strict: Bool) throws(ValidationError) -> ValidationMatch<Double> {
        if let v = value as? Double { return .exact(v) }
        if let v = value as? Int { return .strict(Double(v)) }
        guard !strict else {
            throw ValidationError.doubleType
        }
        if let v = value as? Bool { return .lax(v ? 1.0 : 0.0) }
        if let v = value as? String {
            guard let d = Double(v) else {
                throw ValidationError.doubleParsing
            }
            return .lax(d)
        }
        throw ValidationError.doubleType
    }

    public func validateCharacter(strict: Bool) throws(ValidationError) -> ValidationMatch<Character> {
        if let c = value as? Character { return .exact(c) }

        if let s = value as? String, s.count == 1, let c = s.first {
            return .strict(c)
        }
        if let s = value as? Substring, s.count == 1, let c = s.first {
            return .strict(c)
        }

        guard !strict else {
            throw ValidationError.characterType
        }

        if let s = value as? String, let c = s.first { return .lax(c) }
        if let s = value as? Substring, let c = s.first { return .lax(c) }

        throw ValidationError.characterType
    }

    public func validateArray(strict: Bool) throws(ValidationError) -> ValidationMatch<[AnyInput]> {
        if let arr = value as? [any Sendable] {
            return .exact(arr.map { AnyInput($0) })
        }

        guard !strict else {
            throw .arrayType
        }

        // TODO: lax convertion from set<AnyHashable> or other collection types?
        // https://github.com/vapor/console-kit/blob/main/Sources/ConsoleKit/Utilities/AnySendableHashable.swift#L2

        throw ValidationError.arrayType
    }
}
