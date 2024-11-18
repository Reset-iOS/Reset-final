import UIKit

protocol TextInputViewControllerDelegate: AnyObject {
    func didEnterText(_ text: String)
}

class TextInputViewController: UIViewController {

 
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: TextInputViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the Done button on the navigation bar
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        self.navigationItem.rightBarButtonItem = doneButton
        
        // If the view controller doesn't have a navigation controller, add one
        if self.navigationController == nil {
            let navigationController = UINavigationController(rootViewController: self)
            self.present(navigationController, animated: true, completion: nil)
        }
    }

    @objc func doneButtonPressed() {
        guard let inputText = textField.text, !inputText.isEmpty else { return }
        
        // Pass the entered text to the delegate (root view controller)
        delegate?.didEnterText(inputText)
        
        // Dismiss the modal
        self.dismiss(animated: true, completion: nil)
    }
}
