import UIKit

// Протокол для делегирования нажатия кнопки в ViewController
protocol ButtonDelegate: class {
    func onButtonTap(sender: UIButton)
}

class ViewWithTextAndButton: UIView{

    // Объявляем делегат для использования
    weak var delegate:ButtonDelegate?

}

class ViewController: UIViewController, ButtonDelegate{

    let viewWithTextAndButton = ViewWithTextAndButton(frame:CGRect(x:0, y:0, width:100, height:100))

    let button:UIButton = {
        let button = UIButton()
        button.createRectangleButton(buttonPositionX: 30.0, buttonPositionY: 30.0, buttonWidth: 100.0, buttonHeight: 100.0, buttonTilte: "Hello")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Присваиваем делегат
        viewWithTextAndButton.delegate = self
        view.addSubview(viewWithTextAndButton)
        view.addSubview(button)
    }

    // MARK: ButtonDelegate
    // Реализация делегируемой логики здесь
    func onButtonTap(sender: UIButton) {
        print("This button was clicked in the subview!")
    }
}

extension UIButton {
func createRectangleButton(buttonPositionX: Double, buttonPositionY: Double ,buttonWidth: Double, buttonHeight: Double, buttonTilte: String) {
    let button = self // changes made here
    button.frame = CGRect(x: buttonPositionX, y: buttonPositionY, width: buttonWidth, height: buttonHeight)
    button.setTitle(buttonTilte, for: .normal)
    button.backgroundColor = .green

    }}
