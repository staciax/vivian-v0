public struct ValidationState: Sendable {
    public let config: Config
    public private(set) var exactness: Exactness?
    // public let hasFieldError: Bool = false
    public weak var delegate: (any ValidationDelegate)?

    public func strictOr(_ fallback: Bool) -> Bool {
        return config.strict || fallback
    }
}

extension ValidationState {
    public mutating func floorExactness(_ other: Exactness) {
        if let current = exactness {
            if current == .strict {
                if other == .lax { exactness = .lax }
            } else if current == .exact {
                exactness = other
            }
        }
    }
}
