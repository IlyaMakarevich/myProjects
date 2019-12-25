import UIKit


func multiplyBy(multiplier: Int) -> (Int) -> (Int) {
    return {(item: Int) -> Int in return
       (item * multiplier)
    }
}

let threeMoreTimes = multiplyBy(multiplier: 3)

threeMoreTimes(9)



func ff (number: Int) -> () {
    
}

var fff:((_ number: Int) -> ())?
