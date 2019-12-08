import UIKit

protocol RemoteStarterDelegate {
    func startCar()
}
/*:
 Next, we're going to create the blueprint for our person who will eventually become Janet
 */
class Person {
    let name: String
    var remoteStarterDelegate: RemoteStarterDelegate?

    func pressRemoteStarter() {
        remoteStarterDelegate?.startCar()
    }
    init(name: String) {
        self.name = name
    }
}

/*:
 Simple enough, right? In Swift, protocols are first-class citizens, like strings or doubles or arrays. Just think of line 11  the same as line 10. In line 10, we are giving Janet a property called name, that will be of type string. The next line is exactly the same. Person also has a property called remoteStarterDelegate, that we are telling swift will be of type RemoteStarterDelegate. We can create whatever class we want, as long as it follows the RemoteStarterDelegate protocol, our person can keep track of it. We could create a car, a motorcycle, and a rocketship class that all follow our delegate protocol, and our person could hook their remote starter up to any of them. It's also important to note that we are setting this value as an optional. That's because we might create our person, and then a few minutes later create our car, or we might never create our car, so there is nothing to fill this slot with.
 */

class Car: RemoteStarterDelegate {
    func startCar() {
        print("vroom vroom")
    }
}

/*:
Now we've created our car, which conforms to the delegate we created above. This allows our person to know about the car and send messages to it. However, our person has no idea what happens when they press the button on their remote starter. It might start the car, it might turn on the stereo, or it might deflate the tires. While this might be confusing in our kind of convoluted example at this point, it is important to keep our concerns separate. All our person needs to know is that if they press the button, the car does something. It's up to the car to provide the functionality.
 */
var janet = Person(name: "Janet")
let janetsCar = Car()
janet.remoteStarterDelegate = janetsCar

let ilya = Person(name: "Ilya")
let ilyaCar = Car()
ilya.remoteStarterDelegate = ilyaCar

/*:
 Pretty simple, right? Now we have a person called Janet, and Janet's car. Janet knows that if she presses her button, her car will do something. So, let's press the button finally.
 */

janet.pressRemoteStarter()
ilya.pressRemoteStarter()
