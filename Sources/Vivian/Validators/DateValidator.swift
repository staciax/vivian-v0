import Foundation

public struct DateValidator {
    public let strict: Bool

    public init(strict: Bool) {
        self.strict = strict
    }
}

extension DateValidator: Validator {
    public var name: String { "date" }
    public typealias Output = Date

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let strict = state.strictOr(self.strict)

        if let date = input.asInstance(of: Date.self) {
            return date
        }

        guard !strict else {
            throw ValidationError.dateType
        }

        state.floorExactness(.lax)

        if let timestamp = input.asInstance(of: TimeInterval.self) {
            return Date(timeIntervalSince1970: timestamp)
        }

        if let dateString = input.asInstance(of: String.self) {
            let formatter = ISO8601DateFormatter()
            guard let date = formatter.date(from: dateString) else {
                throw ValidationError.dateParsing(error: "invalid ISO 8601 date string: '\(dateString)'")
            }
            return date
        }

        throw ValidationError.dateType
    }
}
