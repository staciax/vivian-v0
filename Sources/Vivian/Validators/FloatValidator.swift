public struct FloatValidator {
    public let strict: Bool
    public let allowInfiniteAndNaN: Bool

    public init(strict: Bool = false, allowInfiniteAndNaN: Bool = false) {
        self.strict = strict
        self.allowInfiniteAndNaN = allowInfiniteAndNaN
    }
}

extension FloatValidator: Validator {
    public var name: String { "float" }
    public typealias Output = Float

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        let value = try input.validateFloat(strict: strict).resolved(into: &state)

        if !allowInfiniteAndNaN && !value.isFinite {
            throw ValidationError.finiteNumber
        }

        return value
    }
}

struct ConstrainedFloatValidator {
    public let strict: Bool
    public let lt: Float?
    public let le: Float?
    public let gt: Float?
    public let ge: Float?
    public let multipleOf: Float?
    public let allowInfiniteAndNaN: Bool

    public init(
        strict: Bool,
        lt: Float? = nil,
        le: Float? = nil,
        gt: Float? = nil,
        ge: Float? = nil,
        multipleOf: Float? = nil,
        allowInfiniteAndNaN: Bool = false
    ) {
        self.strict = strict
        self.lt = lt
        self.le = le
        self.gt = gt
        self.ge = ge
        self.multipleOf = multipleOf
        self.allowInfiniteAndNaN = allowInfiniteAndNaN
    }
}

extension ConstrainedFloatValidator: Validator {
    public var name: String { "constrained-float" }
    public typealias Output = Float

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        let value = try input.validateFloat(strict: strict).resolved(into: &state)

        if !allowInfiniteAndNaN && !value.isFinite {
            throw ValidationError.finiteNumber
        }

        if let multipleOf = self.multipleOf, value.isFinite {
            let tolerance: Float = 1e-6
            let roundedDivision = (value / multipleOf).rounded()
            let difference = abs((roundedDivision * multipleOf) - value)
            if difference > tolerance {
                throw ValidationError.multipleOf(multipleOf: .float(multipleOf))
            }
        }
        if let le = self.le, !(value <= le) {
            throw ValidationError.lessThanEqual(le: .float(le))
        }
        if let lt = self.lt, !(value < lt) {
            throw ValidationError.lessThan(lt: .float(lt))
        }
        if let ge = self.ge, !(value >= ge) {
            throw ValidationError.greaterThanEqual(ge: .float(ge))
        }
        if let gt = self.gt, !(value > gt) {
            throw ValidationError.greaterThan(gt: .float(gt))
        }
        return value
    }
}
