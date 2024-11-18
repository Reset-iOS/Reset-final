//
//  ImageInputViewController.swift
//  WaterfallLayoutExample
//
//  Created by Prasanjit Panda on 17/11/24.
//

import UIKit


protocol ImageInputViewControllerDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}

class ImageInputViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    weak var delegate: ImageInputViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
                self.navigationItem.rightBarButtonItem = doneButton

        // Do any additional setup after loading the view.
    }
    

@IBAction func chooseImageButtonTapped(_ sender: UIButton) {
        
        // Present an action sheet for image selection
                let actionSheet = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
                
                actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.presentImagePicker(sourceType: .camera)
                }))
                
                actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                    self.presentImagePicker(sourceType: .photoLibrary)
                }))
                
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(actionSheet, animated: true, completion: nil)
        
    }
    
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
           // Check if the selected source type is available
           if UIImagePickerController.isSourceTypeAvailable(sourceType) {
               let picker = UIImagePickerController()
               picker.delegate = self
               picker.sourceType = sourceType
               picker.allowsEditing = true
               present(picker, animated: true, completion: nil)
           }
       }
       
       // UIImagePickerController delegate method
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let selectedImage = info[.editedImage] as? UIImage {
               imageView.image = selectedImage
               delegate?.didSelectImage(selectedImage)
           }
           
           dismiss(animated: true, completion: nil)
       }
       
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }

       @objc func doneButtonPressed() {
           // Dismiss the view controller when done
           self.dismiss(animated: true, completion: nil)
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
