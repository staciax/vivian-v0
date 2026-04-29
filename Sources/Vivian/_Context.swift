// Unfinished feature
// https://developer.apple.com/documentation/synchronization
// requires macOS 15.0+

// import Synchronization

// public enum Context {
//     // global: mutex for shared mutable state across threads
//     private static let _global: Mutex<Config?> = .init(nil)

//     public static var global: Config? {
//         get { _global.withLock { $0 } }
//         set { _global.withLock { $0 = newValue } }
//     }

//     // scoped: TaskLocal per async task
//     @TaskLocal
//     public static var scoped: Config? = nil

//     // priority chain: call-site → scoped → global → default
//     public static func resolved(callSite: Config? = nil) -> Config {
//         callSite ?? scoped ?? global ?? .default
//     }
// }

// global
// Context.global = .init(strict: false, coerceNumbers: true)

// scoped
// await Context.$scoped.withValue(.init(strict: true)) {
//     let user = try User.validate([
//         "name": "Bob",
//         "email": "bob@example.com",
//         "age": 25,
//     ])
// }

// how to use
// var config = Context.resolved(callSite: config)
