public protocol _FieldValue: Sendable {}
extension Optional: _FieldValue where Wrapped: _FieldValue {}

// string fields
public protocol _StringFieldValue: _FieldValue {}

// bool fields
public protocol _BoolFieldValue: _FieldValue {}

// int fields
public protocol _IntFieldValue: _FieldValue {}

// float and double fields
public protocol _DoubleFieldValue: _FieldValue {}
public protocol _FloatFieldValue: _FieldValue {}

// date fields
public protocol _DateFieldValue: _FieldValue {}

// url fields
public protocol _URLFieldValue: _FieldValue {}

// uuid fields
public protocol _UUIDFieldValue: _FieldValue {}
