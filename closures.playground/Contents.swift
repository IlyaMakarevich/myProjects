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

let birthday:(String) -> () = {name in
    print("today is birthday of "+name)
}

birthday("asda")


let carDescription:(String,String) -> () = {(color:String, horsePowers:String) -> () in
    print("My car is \(color) color and has \(horsePowers) horsePowers")
}

let lexus = carDescription("grey","287")

