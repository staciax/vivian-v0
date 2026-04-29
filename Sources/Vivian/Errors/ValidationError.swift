import Foundation

public enum ValidationError: Error, Sendable {

    public enum Number: Sendable, CustomStringConvertible {
        case int(Int)
        case float(Float)
        case double(Double)
        case string(String)

        public var description: String {
            switch self {
            case .int(let v): return String(v)
            case .float(let v): return String(v)
            case .double(let v): return String(v)
            case .string(let v): return v
            }
        }
    }

    // json

    // case jsonInvalid(error: String)
    // case jsonType

    // recursion

    // case recursionLoop

    // struct / model

    // case missing
    // case frozenField
    // case frozenInstance
    // case extraForbidden
    // case invalidKey

    // nil

    case nilRequired

    // number constraints

    case greaterThan(gt: Number)
    case greaterThanEqual(ge: Number)
    case lessThan(lt: Number)
    case lessThanEqual(le: Number)
    case multipleOf(multipleOf: Number)
    case finiteNumber

    // generic length (array, set, dict, etc.)
    case tooShort(fieldType: String, minLength: Int, actualLength: Int)
    case tooLong(fieldType: String, maxLength: Int, actualLength: Int)

    // iterable

    // case iterableType
    // case iterationError(error: String)

    // string

    case stringType
    case stringUnicode
    case stringTooShort(minLength: Int)
    case stringTooLong(maxLength: Int)
    case stringPatternMismatch(pattern: String)

    // enum

    // case enumType(expected: String)

    // dict

    case dictType

    // array

    case arrayType

    // tuple

    case tupleType

    // set

    case setType

    // character

    case characterType

    // bool

    case boolType
    case boolParsing

    // int

    case intType
    case intParsing
    case intFromFloat

    // float

    case floatType
    case floatParsing

    // double (Swift-specific)

    case doubleType
    case doubleParsing

    // data (bytes)

    case dataType
    // case dataTooShort(minLength: Int)
    // case dataTooLong(maxLength: Int)
    // case dataInvalidEncoding(encoding: String, error: String)

    // literal

    // case literalError(expected: String)

    // date

    case dateType
    case dateParsing(error: String)
    // case datePast
    // case dateFuture

    // time

    // case timeType
    // case timeParsing(error: String)

    // datetime

    // case datetimeType
    // case datetimeParsing(error: String)
    // case datetimePast
    // case datetimeFuture

    // timezone

    // case timezoneNaive
    // case timezoneAware
    // case timezoneOffset(expected: Int, actual: Int)

    // url

    case urlType
    case urlParsing(error: String)
    // case urlTooLong(maxLength: Int)
    // case urlScheme(expectedSchemes: String)

    // uuid

    case uuidType
    case uuidParsing(error: String)
    case uuidVersion(expectedVersion: UInt8)

    // decimal

    // case decimalType
    // case decimalParsing
    // case decimalMaxDigits(maxDigits: Int)
    // case decimalMaxPlaces(decimalPlaces: Int)
    // case decimalWholeDigits(wholeDigits: Int)

    // union

    // case unionTagInvalid(discriminator: String, tag: String, expectedTags: String)
    // case unionTagNotFound(discriminator: String)

    // custom

    case custom(message: String)
}

extension ValidationError {
    public var code: String {
        switch self {
        // json
        // case .jsonInvalid:          return "json_invalid"
        // case .jsonType:             return "json_type"
        // recursion
        // case .recursionLoop:        return "recursion_loop"
        // struct / model
        // case .missing:              return "missing"
        // case .frozenField:          return "frozen_field"
        // case .frozenInstance:       return "frozen_instance"
        // case .extraForbidden:       return "extra_forbidden"
        // case .invalidKey:           return "invalid_key"
        // nil
        case .nilRequired: return "nil_required"
        // number constraints
        case .greaterThan: return "greater_than"
        case .greaterThanEqual: return "greater_than_equal"
        case .lessThan: return "less_than"
        case .lessThanEqual: return "less_than_equal"
        case .multipleOf: return "multiple_of"
        case .finiteNumber: return "finite_number"
        // generic length
        case .tooShort: return "too_short"
        case .tooLong: return "too_long"
        // iterable
        // case .iterableType:         return "iterable_type"
        // case .iterationError:       return "iteration_error"
        // string
        case .stringType: return "string_type"
        case .stringUnicode: return "string_unicode"
        case .stringTooShort: return "string_too_short"
        case .stringTooLong: return "string_too_long"
        case .stringPatternMismatch: return "string_pattern_mismatch"
        // enum
        // case .enumType: return "enum_type"
        // dict
        case .dictType: return "dict_type"
        // array
        case .arrayType: return "array_type"
        // tuple
        case .tupleType: return "tuple_type"
        // set
        case .setType: return "set_type"
        // character
        case .characterType: return "character_type"
        // bool
        case .boolType: return "bool_type"
        case .boolParsing: return "bool_parsing"
        // int
        case .intType: return "int_type"
        case .intParsing: return "int_parsing"
        case .intFromFloat: return "int_from_float"
        // float
        case .floatType: return "float_type"
        case .floatParsing: return "float_parsing"
        // double
        case .doubleType: return "double_type"
        case .doubleParsing: return "double_parsing"
        // data
        case .dataType: return "data_type"
        // case .dataTooShort:         return "data_too_short"
        // case .dataTooLong:          return "data_too_long"
        // case .dataInvalidEncoding:  return "data_invalid_encoding"
        // literal
        // case .literalError:         return "literal_error"
        // date
        case .dateType: return "date_type"
        case .dateParsing: return "date_parsing"
        // case .datePast:             return "date_past"
        // case .dateFuture:           return "date_future"
        // time
        // case .timeType:             return "time_type"
        // case .timeParsing:          return "time_parsing"
        // datetime
        // case .datetimeType:         return "datetime_type"
        // case .datetimeParsing:      return "datetime_parsing"
        // case .datetimePast:         return "datetime_past"
        // case .datetimeFuture:       return "datetime_future"
        // timezone
        // case .timezoneNaive:        return "timezone_naive"
        // case .timezoneAware:        return "timezone_aware"
        // case .timezoneOffset:       return "timezone_offset"
        // url
        case .urlType: return "url_type"
        case .urlParsing: return "url_parsing"
        // case .urlTooLong:           return "url_too_long"
        // case .urlScheme:            return "url_scheme"
        // uuid
        case .uuidType: return "uuid_type"
        case .uuidParsing: return "uuid_parsing"
        case .uuidVersion: return "uuid_version"
        // decimal
        // case .decimalType:          return "decimal_type"
        // case .decimalParsing:       return "decimal_parsing"
        // case .decimalMaxDigits:     return "decimal_max_digits"
        // case .decimalMaxPlaces:     return "decimal_max_places"
        // case .decimalWholeDigits:   return "decimal_whole_digits"
        // union
        // case .unionTagInvalid:      return "union_tag_invalid"
        // case .unionTagNotFound:     return "union_tag_not_found"
        // custom
        case .custom: return "custom"
        }
    }
}

extension ValidationError {
    public var message: String {
        switch self {
        // json
        // case .jsonInvalid(let error):             return "Invalid JSON: \(error)"
        // case .jsonType:                           return "JSON input should be a string or Data"
        // recursion
        // case .recursionLoop:                      return "Recursion error - cyclic reference detected"
        // struct / model
        // case .missing:                            return "Field required"
        // case .frozenField:                        return "Field is frozen"
        // case .frozenInstance:                     return "Instance is frozen"
        // case .extraForbidden:                     return "Extra inputs are not permitted"
        // case .invalidKey:                         return "Keys should be strings"
        // nil
        case .nilRequired: return "Input should be nil"
        // number constraints
        case .greaterThan(let gt): return "Input should be greater than \(gt)"
        case .greaterThanEqual(let ge): return "Input should be greater than or equal to \(ge)"
        case .lessThan(let lt): return "Input should be less than \(lt)"
        case .lessThanEqual(let le): return "Input should be less than or equal to \(le)"
        case .multipleOf(let v): return "Input should be a multiple of \(v)"
        case .finiteNumber: return "Input should be a finite number"
        // generic length
        case .tooShort(let t, let min, let act): return "\(t) should have at least \(min) items, not \(act)"
        case .tooLong(let t, let max, let act): return "\(t) should have at most \(max) items, not \(act)"
        // iterable
        // case .iterableType:                       return "Input should be iterable"
        // case .iterationError(let error):          return "Error iterating over object: \(error)"
        // string
        case .stringType: return "Input should be a valid string"
        case .stringUnicode: return "Input should be a valid string, unable to parse raw data as a unicode string"
        case .stringTooShort(let minLength): return "String should have at least \(minLength) characters"
        case .stringTooLong(let maxLength): return "String should have at most \(maxLength) characters"
        case .stringPatternMismatch(let pattern): return "String should match pattern '\(pattern)'"
        // enum
        // case .enumType(let expected): return "Input should be \(expected)"
        // dict
        case .dictType: return "Input should be a valid dictionary"
        // array
        case .arrayType: return "Input should be a valid array"
        // tuple
        case .tupleType: return "Input should be a valid tuple"
        // set
        case .setType: return "Input should be a valid set"
        // character
        case .characterType: return "Input should be a valid character"
        // bool
        case .boolType: return "Input should be a valid boolean"
        case .boolParsing: return "Input should be a valid boolean, unable to interpret input"
        // int
        case .intType: return "Input should be a valid integer"
        case .intParsing: return "Input should be a valid integer, unable to parse string as an integer"
        case .intFromFloat: return "Input should be a valid integer, got a number with a fractional part"
        // float
        case .floatType: return "Input should be a valid float"
        case .floatParsing: return "Input should be a valid float, unable to parse string as a float"
        // double
        case .doubleType: return "Input should be a valid double"
        case .doubleParsing: return "Input should be a valid double, unable to parse string as a double"
        // data
        case .dataType: return "Input should be valid data"
        // case .dataTooShort(let minLength):         return "Data should have at least \(minLength) bytes"
        // case .dataTooLong(let maxLength):           return "Data should have at most \(maxLength) bytes"
        // case .dataInvalidEncoding(let enc, let e): return "Data should be valid \(enc): \(e)"
        // literal
        // case .literalError(let expected):         return "Input should be \(expected)"
        // date
        case .dateType: return "Input should be a valid date"
        case .dateParsing(let error): return "Input should be a valid date, \(error)"
        // case .datePast:                           return "Date should be in the past"
        // case .dateFuture:                         return "Date should be in the future"
        // time
        // case .timeType:                           return "Input should be a valid time"
        // case .timeParsing(let error):             return "Input should be in a valid time format, \(error)"
        // datetime
        // case .datetimeType:                       return "Input should be a valid datetime"
        // case .datetimeParsing(let error):         return "Input should be a valid datetime, \(error)"
        // case .datetimePast:                       return "Input should be in the past"
        // case .datetimeFuture:                     return "Input should be in the future"
        // timezone
        // case .timezoneNaive:                      return "Input should not have timezone info"
        // case .timezoneAware:                      return "Input should have timezone info"
        // case .timezoneOffset(let exp, let act):   return "Timezone offset of \(exp) required, got \(act)"
        // url
        case .urlType: return "URL input should be a string or URL"
        case .urlParsing(let error): return "Input should be a valid URL, \(error)"
        // case .urlTooLong(let maxLength):           return "URL should have at most \(maxLength) characters"
        // case .urlScheme(let schemes):             return "URL scheme should be \(schemes)"
        // uuid
        case .uuidType: return "UUID input should be a string or UUID"
        case .uuidParsing(let error): return "Input should be a valid UUID, \(error)"
        case .uuidVersion(let v): return "UUID version \(v) expected"
        // decimal
        // case .decimalType:                        return "Decimal input should be an integer, float, string or Decimal"
        // case .decimalParsing:                     return "Input should be a valid decimal"
        // case .decimalMaxDigits(let maxDigits):     return "Decimal input should have no more than \(maxDigits) digits in total"
        // case .decimalMaxPlaces(let places):        return "Decimal input should have no more than \(places) decimal places"
        // case .decimalWholeDigits(let digits):      return "Decimal input should have no more than \(digits) digits before the decimal point"
        // union
        // case .unionTagInvalid(let d, let t, let e): return "Input tag '\(t)' found using \(d) does not match any of the expected tags: \(e)"
        // case .unionTagNotFound(let d):            return "Unable to extract tag using discriminator \(d)"
        // custom
        case .custom(let message): return message
        }
    }
}
