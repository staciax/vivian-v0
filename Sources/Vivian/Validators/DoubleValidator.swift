public struct DoubleValidator {
    public let strict: Bool
    public let allowInfiniteAndNaN: Bool

    public init(strict: Bool = false, allowInfiniteAndNaN: Bool = false) {
        self.strict = strict
        self.allowInfiniteAndNaN = allowInfiniteAndNaN
    }
}

extension DoubleValidator: Validator {
    public var name: String { "double" }
    public typealias Output = Double

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        let value = try input.validateDouble(strict: strict).resolved(into: &state)

        if !allowInfiniteAndNaN && !value.isFinite {
            throw ValidationError.finiteNumber
        }

        return value
    }
}

struct ConstrainedDoubleValidator {
    public let strict: Bool
    public let lt: Double?
    public let le: Double?
    public let gt: Double?
    public let ge: Double?
    public let multipleOf: Double?
    public let allowInfiniteAndNaN: Bool

    public init(
        strict: Bool,
        lt: Double? = nil,
        le: Double? = nil,
        gt: Double? = nil,
        ge: Double? = nil,
        multipleOf: Double? = nil,
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

extension ConstrainedDoubleValidator: Validator {
    public var name: String { "constrained-double" }
    public typealias Output = Double

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        let value = try input.validateDouble(strict: strict).resolved(into: &state)

        if !allowInfiniteAndNaN && !value.isFinite {
            throw ValidationError.finiteNumber
        }

        if let multipleOf = self.multipleOf, value.isFinite {
            let tolerance = 1e-9
            let roundedDivision = (value / multipleOf).rounded()
            let difference = abs((roundedDivision * multipleOf) - value)
            if difference > tolerance {
                throw ValidationError.multipleOf(multipleOf: .double(multipleOf))
            }
        }
        if let le = self.le, !(value <= le) {
            throw ValidationError.lessThanEqual(le: .double(le))
        }
        if let lt = self.lt, !(value < lt) {
            throw ValidationError.lessThan(lt: .double(lt))
        }
        if let ge = self.ge, !(value >= ge) {
            throw ValidationError.greaterThanEqual(ge: .double(ge))
        }
        if let gt = self.gt, !(value > gt) {
            throw ValidationError.greaterThan(gt: .double(gt))
        }
        return value
    }
}
