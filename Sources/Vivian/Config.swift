public struct Config: Sendable {
    public enum Extra: Sendable {
        case ignore
        case allow
        case forbid
    }

    public var strict: Bool = false

    // string
    // public var stringToLower: Bool = false
    // public var stringToUpper: Bool = false
    // public var stringStripWhitespace: Bool = false
    // public var stringMinLength: Int? = nil
    // public var stringMaxLength: Int? = nil

    // extra fields
    // public var extra: Extra = .ignore

    // public var allowInfiniteAndNaN: Bool = true

    // public var validateDefault = false

    // public var hideInputInErrors = false

    // public var coerceNumbersToString = false

    public static let `default` = Config()
}
