import Foundation
import Testing

@testable import Vivian

@Test(arguments: [
    ("b71b16f4-3b26-11f1-be1d-f1309c481260", UUIDVersion.v1),
    ("000003e8-3b26-21f1-9f00-325096b39f47", .v2),
    ("9073926b-929f-31c2-abc9-fad77ae3e8eb", .v3),
    ("024b7df7-6a1d-4d24-bc86-9fb5b628f8b0", .v4),
    ("cfbff0d1-9375-5685-968c-48ce8b15ae17", .v5),
    ("1f13b26b-71b4-65c0-991d-00e04c36da25", .v6),
    ("019da0ae-9502-7211-93ac-8a59b28c58ae", .v7),
    ("6e4620d9-f992-8a7c-873f-eb312216a490", .v8),
])
func testUUIDSchema(_ input: String, version: UUIDVersion) throws {
    var state = ValidationState(config: Config.default)
    let schema = UUIDSchema(strict: false, version: version.rawValue)
    try schema.validate(input, state: &state)
}
