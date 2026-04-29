public protocol ValidationDelegate: AnyObject, Sendable {
    func validator(_ validator: any Validator, willValidate input: AnyInput)
    func validator(_ validator: any Validator, didFailWith error: any Error)
    func validator(_ validator: any Validator, didSucceedWith output: Any)
}
