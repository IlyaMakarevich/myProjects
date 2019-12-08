import UIKit

func filterWithPredicateClosure(closure: (Int) -> Bool, numbers:[Int]) -> [Int] {
    var filteredNumbers = [Int]()
    for num in numbers {
        if closure(num) {
            filteredNumbers.append(num)
        }
    }
    return filteredNumbers
}

let numbers = [4,5,6,7,8,35,34,555,666]

func greaterThanNine(value: Int) -> Bool {
    return value > 9
}

let arrayNumbersGreaterThanNine = filterWithPredicateClosure(closure: greaterThanNine(value:), numbers: numbers)

