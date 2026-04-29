import Foundation

extension UUID {

    public var version: UInt8 {
        uuid.6 >> 4
    }

    // public func isVersion(_ version: UInt8) -> Bool {
    //     self.version == version
    // }
}
