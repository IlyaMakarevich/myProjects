//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

protocol DeliverPizzaDelegate {
    func deliverPizza(type:String)
}
class MyViewController {
    let pizza = "Margaritta"
    var delegate: DeliverPizzaDelegate?

    func makePizza() {
        delegate?.deliverPizza(type: pizza)
    }
}


class Empployee: DeliverPizzaDelegate{
    let deleverer = MyViewController()

    func deliverPizza(type: String) {
        deleverer.delegate = self
        print("I will deliver \(type)")
    }
}


let cafe = MyViewController()
let slave = Empployee()
cafe.delegate = slave

cafe.makePizza()

class User {
    var name: String
    init(name: String) {
        self.name = name
    }
}




