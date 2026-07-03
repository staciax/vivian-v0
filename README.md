# Vivian

> _"Make data safe. Just let it validate."_

A Swift-based library for data validation and parsing. It helps you validate inputs, sanitize fields, and decode them into type-safe models, structured exactly the way you want.

---

This is the 3rd project for the Swift Programming course, created to apply the fundamentals learned in the course.

It follows a strict, course-defined scope (see [CHECKLIST.md](CHECKLIST.md) for exact requirements).

Due to the submission deadline on **April 17, 2026**, some parts may be incomplete or experimental.

The project covers the following topics:

- [Extensions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions)
- [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols)
- [Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics)
- [Opaque and Boxed Protocol Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes)
- [Automatic Reference Counting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting)
- [Memory Safety](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/memorysafety)
- [Access Control](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol)
- [Advanced Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators)

## Inspiration

Vivian is heavily inspired by [Pydantic](https://pydantic.dev) — my personal favorite Python library. Most of the architecture is adapted from [pydantic-core](https://github.com/pydantic/pydantic/tree/main/pydantic-core), rewritten for Swift's type system.

Started with [Property Wrappers](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties#Property-Wrappers) to mimic Pydantic's field syntax, but `var`-only stored properties made it awkward. Switched to [Result Builders](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators#Result-Builders) — more declarative, though full type-safety within the course scope got complicated fast. The API is still evolving and may change over time.

## Prerequisites

- **Swift 6.2+**
- **macOS 13+** (for [Regex](https://developer.apple.com/documentation/swift/regex) support)

### Running the project

1. Clone the repository

```bash
git clone https://github.com/staciax/vivian-v0.git
```

2. Build the package

```bash
swift build
```

3. Run tests

```bash
swift test
```

## Quick Example

```swift
import Foundation

struct User: Codable {
    let id: UUID
    let name: String
    let email: String
    let createdAt: Date
}

let schema = ObjectSchema<User> {
    Field(\.id, version: .v7)
    Field(
        \.name,
        minLength: 1,
        maxLength: 50,
        trim: true,
        toLowercase: true,
        before: { value in
            if let s = value as? String {
                return s + " (uwu)"
            }
            return value
        },
        after: {
            value in
            return value.replacingOccurrences(of: "(uwu)", with: "(owo)")
        }
    )
    Field(\.email, format: .email)
    Field(\.createdAt, format: .iso8601)
}

let jsonData = """
{
    "id": "019d9aa8-ee5f-7f39-998f-de8f1fd945b2",
    "name": "STAC/A",
    "email": "me@stacia.me",
    "createdAt": 1776390743
}""".data(using: .utf8)!

let user = try schema.validate(jsonData)
print(user.id)          // 019D9AA8-EE5F-7F39-998F-DE8F1FD945B2
print(user.name)        // stac/a (owo)
print(user.email)       // me@stacia.me
print(user.createdAt)   // 2057-04-17 01:52:23 +0000

// maybe timezone is broken :)
```

## License & Copyright

This repository is a prototype developed for an academic project.

**All rights reserved.**

No permission is granted to use, copy, modify, or distribute this source code, in whole or in part, without explicit prior written consent.

This repository is provided for viewing and educational purposes only. It is not intended for production use.

## Appreciation

A heartfelt thank you to my professor for the guidance and support throughout these years.

From Object-Oriented Programming and Design Patterns to Swift, your teaching has shaped the way I approach software and problem-solving. I’m truly grateful to have learned from you — it’s been a meaningful part of my journey as a developer.

I just want to say thank you. It really means a lot. <3
