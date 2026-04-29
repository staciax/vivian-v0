import Foundation

public struct StringValidator {
    public let strict: Bool
    public let coerceNumbersToString: Bool

    public init(strict: Bool, coerceNumbersToString: Bool = false) {
        self.strict = strict
        self.coerceNumbersToString = coerceNumbersToString
    }
}

extension StringValidator: Validator {
    public var name: String { "string" }
    public typealias Output = String

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        let value = try input.validateString(strict: strict, coerceNumbersToString: self.coerceNumbersToString)
            .resolved(into: &state)
        return value
    }
}

public struct StringConstrainedValidator<PatternOutput>: Sendable where PatternOutput: Sendable {
    let strict: Bool
    let pattern: Pattern<PatternOutput>?
    let minLength: Int?
    let maxLength: Int?
    let trim: Bool
    let toLowercase: Bool
    let toUppercase: Bool
    let coerceNumbersToString: Bool

    init(
        strict: Bool,
        pattern: Pattern<PatternOutput>? = nil,
        minLength: Int? = nil,
        maxLength: Int? = nil,
        trim: Bool = false,
        toLowercase: Bool = false,
        toUppercase: Bool = false,
        coerceNumbersToString: Bool = false
    ) {
        precondition(!(toLowercase && toUppercase), "Cannot set both toLowercase and toUppercase to true")
        self.strict = strict
        self.pattern = pattern
        self.minLength = minLength
        self.maxLength = maxLength
        self.trim = trim
        self.toLowercase = toLowercase
        self.toUppercase = toUppercase
        self.coerceNumbersToString = coerceNumbersToString
    }

    func hasConstraintsSet() -> Bool {
        return pattern != nil
            || maxLength != nil
            || minLength != nil
            || trim
            || toLowercase
            || toUppercase
    }
}

extension StringConstrainedValidator: Validator {
    public var name: String { "string-constrained" }
    public typealias Output = String

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)

        var value =
            try input
            .validateString(strict: strict, coerceNumbersToString: coerceNumbersToString)
            .resolved(into: &state)

        if trim {
            value = value.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        if minLength != nil || maxLength != nil {
            let count = value.count
            if let minLength, count < minLength {
                throw ValidationError.stringTooShort(minLength: minLength)
            }
            if let maxLength, count > maxLength {
                throw ValidationError.stringTooLong(maxLength: maxLength)
            }
        }

        if let pattern, try pattern.match(for: value) == nil {
            throw ValidationError.stringPatternMismatch(pattern: String(describing: pattern.pattern))
        }

        if toLowercase {
            return value.lowercased()
        } else if toUppercase {
            return value.uppercased()
        }

        return value
    }
}

public struct Pattern<Output>: Sendable where Output: Sendable {
    nonisolated(unsafe) public let pattern: Regex<Output>
    // Regex<Output> lacks Sendable conformance in the stdlib (as of Swift 6);
    // safe here because Regex is immutable after initialization.

    public init(_ pattern: Regex<Output>) {
        self.pattern = pattern
    }

    public func match(for target: String) throws -> Output? {
        (try pattern.firstMatch(in: target))?.output
    }

    public func isMatch(for target: String) throws -> Bool {
        try match(for: target) != nil
    }
}
