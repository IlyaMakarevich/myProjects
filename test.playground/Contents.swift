import UIKit

//сделать на swift функцию enumerate чтобы находило по очереди все встречи данной substring, вызывая completion c параметрами Range & stop

//    public func wl_enumerateSubstrings(_ substr: String, body: (_ range: Range<String.Index>, _ stop: inout Bool) -> Void)

let str = "Hello playground,Hello, playground, Hello, playground, Hello, playground, Hello, playground"
str[str.startIndex]


extension StringProtocol {
        func ranges(of targetString: Self, options: String.CompareOptions = [], locale: Locale? = nil) -> [Range<String.Index>] {

            let result: [Range<String.Index>] = self.indices.compactMap { startIndex in
                let targetStringEndIndex = index(startIndex, offsetBy: targetString.count, limitedBy: endIndex) ?? endIndex
                return range(of: targetString, options: options, range: startIndex..<targetStringEndIndex, locale: locale)
            }
            return result
        }
}

let ranges = str.ranges(of: "play")
ranges.forEach {
    print("[\($0.lowerBound.utf16Offset(in: str)), \($0.upperBound.utf16Offset(in: str))]")
}

extension String {
  func wl_enumerateSubstrings (substring: String, completion:(Range<String.Index>) -> (Bool)) {
    if let range = range(of: substring, range: self.startIndex..<self.endIndex) {
      completion(range)
    }
  }
}


