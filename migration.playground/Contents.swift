import UIKit


let str = "3232"
var iPhone4 = false



class Person {
    let name: String

    init() {
        self.name = "Ilya"
    }

    func showName() -> String {
        print(name)
        return name
    }
}

let man = Person()
man.showName()






print(iPhone4)

extension UIView {
func wlBaselineY() -> CGFloat {
       var baselineY:CGFloat = 1.0
       return baselineY
   }


func wlSuperviewBaselineY() -> CGFloat {
    var baselineY:CGFloat = wlBaselineY()
    if self.superview == nil {
        baselineY += 5.0
    }
    return baselineY

}


}

let testView = UIView()
testView.wlSuperviewBaselineY()



