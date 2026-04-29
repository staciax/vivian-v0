import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // mutating func trimming(after: Character) {
    //     self = self.trim()
    //     // let (trimmed, _) = self.split(at: after)
    //     // return trimmed
    // }
}

extension String {
    // func split(at character: Character) -> (String, String?) {
    //     guard let index = self.firstIndex(of: character) else {
    //         return (self, nil)
    //     }
    //     let before = String(self[..<index])
    //     let after = String(self[self.index(after: index)...])
    //     return (before, after)
    // }
}
