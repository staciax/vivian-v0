import Foundation

public struct UrlConstraints: Sendable {
    public let allowedSchemes: [String]?
    public let hostRequired: Bool?
    public let defaultHost: String?
    public let defaultPort: Int?
    public let defaultPath: String?
    public let preserveEmptyPath: Bool?
    public let maxLength: Int?

    public init(
        allowedSchemes: [String]? = nil,
        hostRequired: Bool? = nil,
        defaultHost: String? = nil,
        defaultPort: Int? = nil,
        defaultPath: String? = nil,
        preserveEmptyPath: Bool? = nil,
        maxLength: Int? = nil,
    ) {
        self.maxLength = maxLength
        self.allowedSchemes = allowedSchemes
        self.hostRequired = hostRequired
        self.defaultHost = defaultHost
        self.defaultPort = defaultPort
        self.defaultPath = defaultPath
        self.preserveEmptyPath = preserveEmptyPath
    }
}

public struct URLValidator {
    let strict: Bool
    let constraints: UrlConstraints?

    public init(
        strict: Bool = false,
        constraints: UrlConstraints? = nil
    ) {
        self.strict = strict
        self.constraints = constraints
    }
}

extension URLValidator: Validator {
    public var name: String { "url" }
    public typealias Output = URL

    public func validate(_ input: AnyInput, state: inout ValidationState) throws -> Output {
        let url = try self.getURL(input, state: &state)

        // TODO: apply constraints

        return url
    }

    private func getURL(
        _ input: AnyInput,
        state: inout ValidationState
    ) throws -> URL {
        if let url = input.asInstance(of: URL.self) {
            return url
        }

        guard !state.strictOr(strict) else {
            throw ValidationError.urlType
        }

        state.floorExactness(.lax)
        let raw = try input.validateString(strict: true, coerceNumbersToString: false).value
        guard let url = URL(string: raw) else {
            throw ValidationError.urlParsing(error: "invalid URL string: '\(raw)'")
        }

        return url
    }
}
