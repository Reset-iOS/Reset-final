//
//  TestViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 13/11/24.
//

import UIKit

class TestViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func imagePickButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Select Image", message: "Choose an option", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))
                
                alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                    self.openPhotoLibrary()
                }))
                
                alert.addAction(UIAlertAction(title: "Document", style: .default, handler: { _ in
                    self.openDocumentPicker()
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)

    }
    
    func openCamera() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }
    func openPhotoLibrary() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    
    func openDocumentPicker() {
            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.image], asCopy: true)
        documentPicker.delegate = self as? UIDocumentPickerDelegate
            self.present(documentPicker, animated: true, completion: nil)
        }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            if let selectedImage = info[.originalImage] as? UIImage {
                self.image.image = selectedImage
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        // MARK: - UIDocumentPickerDelegate
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                self.image.image = image
            }
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            controller.dismiss(animated: true, completion: nil)
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
