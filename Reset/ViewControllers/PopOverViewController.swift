//
//  PopoverViewController.swift
//  WaterfallLayoutExample
//
//  Created by Prasanjit Panda on 17/11/24.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet weak var editOptions: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print("0")
            showTextInputModal()
        }
        
        if sender.selectedSegmentIndex == 1 {
            print("1")
            showImageInputModal()
        }
    }
    
    func showTextInputModal() {
        // Present the TextInputViewController modally inside a UINavigationController
        if let rootVC = self.presentingViewController as? HomeViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let textInputVC = storyboard.instantiateViewController(withIdentifier: "TextInputViewController") as? TextInputViewController {
                let navigationController = UINavigationController(rootViewController: textInputVC)
                textInputVC.modalPresentationStyle = .fullScreen
                textInputVC.delegate = rootVC as? any TextInputViewControllerDelegate // Assign root view controller as the delegate
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }
    
    func showImageInputModal(){
        // Present the TextInputViewController modally inside a UINavigationController
        if let rootVC = self.presentingViewController as? HomeViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let imageInputVC = storyboard.instantiateViewController(withIdentifier: "ImageInputViewController") as? ImageInputViewController {
                let navigationController = UINavigationController(rootViewController: imageInputVC)
                imageInputVC.modalPresentationStyle = .fullScreen
                imageInputVC.delegate = rootVC as? any ImageInputViewControllerDelegate // Assign root view controller as the delegate
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
