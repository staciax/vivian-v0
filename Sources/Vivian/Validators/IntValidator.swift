public struct IntValidator {
    public let strict: Bool

    public init(strict: Bool) {
        self.strict = strict
    }
}

extension IntValidator: Validator {
    public var name: String { "int" }
    public typealias Output = Int

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)
        let value = try input.validateInt(strict: strict).resolved(into: &state)
        return value
    }
}

public struct ConstrainedIntValidator {
    public let strict: Bool
    public let lt: Int?
    public let le: Int?
    public let gt: Int?
    public let ge: Int?
    public let multipleOf: Int?

    // TODO: use closed range instead of separate gt/ge and lt/le? or add support for both?

    public init(
        strict: Bool,
        lt: Int? = nil,
        le: Int? = nil,
        gt: Int? = nil,
        ge: Int? = nil,
        multipleOf: Int? = nil
    ) {
        self.strict = strict
        self.lt = lt
        self.le = le
        self.gt = gt
        self.ge = ge
        self.multipleOf = multipleOf
    }
}

extension ConstrainedIntValidator: Validator {
    public var name: String { "constrained-int" }
    public typealias Output = Int

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {

        let strict = state.strictOr(self.strict)
        let value = try input.validateInt(strict: strict).resolved(into: &state)

        if let multipleOf = self.multipleOf, value % multipleOf != 0 {
            throw ValidationError.multipleOf(multipleOf: .int(multipleOf))
        }

        if let le = self.le, value > le {
            throw ValidationError.lessThanEqual(le: .int(le))
        }

        if let lt = self.lt, value >= lt {
            throw ValidationError.lessThan(lt: .int(lt))
        }

        if let ge = self.ge, value < ge {
            throw ValidationError.greaterThanEqual(ge: .int(ge))
        }

        if let gt = self.gt, value <= gt {
            throw ValidationError.greaterThan(gt: .int(gt))
        }

        return value
    }
}

// public init(
//     strict: Bool,
//     range: any RangeExpression<Int>,
//     multipleOf: Int? = nil
// ) {
//     self.strict = strict
//     self.multipleOf = multipleOf

//     // get the actual bounds from the range expression
//     let bounds = range.relative(to: 0..<0)

//     if bounds.lowerBound != Int.min {
//         if bounds.isEmpty {
//             fatalError(
//                 "Invalid range: lower bound \(bounds.lowerBound) is not less than upper bound \(bounds.upperBound)")
//         }
//         self.ge = bounds.lowerBound
//     } else {
//         self.ge = nil
//     }

//     if bounds.upperBound != Int.max {
//         if bounds.isEmpty {
//             fatalError(
//                 "Invalid range: upper bound \(bounds.upperBound) is not greater than lower bound \(bounds.lowerBound)"
//             )
//         }
//         self.lt = bounds.upperBound
//     } else {
//         self.lt = nil
//     }

//     self.le = nil
//     self.gt = nil
// }
