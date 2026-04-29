import Foundation

public enum UUIDVersion: UInt8, CaseIterable, Sendable {
    case v1 = 1
    case v2, v3, v4, v5, v6, v7, v8
}

// extension UInt8 {
//     public init(uuid version: UUIDVersion) {
//         self = version.rawValue
//     }
// }

public struct UUIDValidator {
    let strict: Bool
    let version: UInt8?

    public init(
        strict: Bool = false,
        version: UInt8? = nil
    ) {
        self.strict = strict
        self.version = version
    }
}

extension UUIDValidator: Validator {
    public var name: String { "uuid" }
    public typealias Output = UUID

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {

        if let uuid = input.asInstance(of: UUID.self) {
            if let version = self.version, uuid.version != version {
                throw ValidationError.uuidVersion(expectedVersion: version)
            }
            return uuid
        }

        guard !state.strictOr(strict) else {
            throw ValidationError.uuidType
        }

        state.floorExactness(.lax)
        let uuidString = try input.validateString(strict: true, coerceNumbersToString: false).value
        if let uuid = UUID(uuidString: uuidString) {
            if let version = self.version, uuid.version != version {
                throw ValidationError.uuidVersion(expectedVersion: version)
            }
            return uuid
        }

        throw ValidationError.uuidParsing(error: "invalid UUID string: '\(uuidString)'")
    }
}
