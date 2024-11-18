//
//  PostsViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 14/11/24.
//

import UIKit

class AddPostsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UITextViewDelegate {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    @IBOutlet weak var postTextView: UITextView!
    
    var mockUsers: [User] = DataManager.shared.loadUsers()
    var mockPosts: [Post] = DataManager.shared.loadPosts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard postImage != nil else {
                    print("postImage is not connected")
                    return
                }
        postImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showImagePickerAlert))
        postImage.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
        
        placeHolderLabel.isHidden = !postTextView.text.isEmpty
        postTextView.delegate = self
    }
    
    @objc func showImagePickerAlert() {
           let alert = UIAlertController(title: "Select Image", message: "Choose your image source", preferredStyle: .actionSheet)
           
           alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
               self.openImagePicker(sourceType: .camera)
           }))
           
           alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
               self.openImagePicker(sourceType: .photoLibrary)
           }))
           
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           
           // Show the alert
           present(alert, animated: true, completion: nil)
       }
       


    // Open UIImagePickerController with the chosen source type
        func openImagePicker(sourceType: UIImagePickerController.SourceType) {
            guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
        
        // Handle image selection
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.editedImage] as? UIImage {
                postImage.image = selectedImage
            } else if let selectedImage = info[.originalImage] as? UIImage {
                postImage.image = selectedImage
            }
            dismiss(animated: true, completion: nil)
        }
        
        // Handle cancel action
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }

    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !postTextView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolderLabel.isHidden = true
    }
    
    func saveImageToDocumentsDirectory(image: UIImage) -> String? {
            guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
            
            let uniqueID = UUID().uuidString  // Generate a unique identifier
            let fileURL = getDocumentsDirectory().appendingPathComponent("\(uniqueID).jpg")
            
            do {
                try data.write(to: fileURL)
                return uniqueID
            } catch {
                print("Error saving image: \(error)")
                return nil
            }
        }
    func getDocumentsDirectory() -> URL {
           return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       }
       
       // Load image from Documents Directory
       func loadImageFromDocumentsDirectory(imageID: String) -> UIImage? {
           let fileURL = getDocumentsDirectory().appendingPathComponent("\(imageID).jpg")
           return UIImage(contentsOfFile: fileURL.path)
       }
    
    func addNewPost(user: User, text: String, image: UIImage?) {
            let imageID: String? = image != nil ? saveImageToDocumentsDirectory(image: image!) : nil
            
            let newPost = Post(
                user: user,
                postDate: Date(),
                postText: text,
                postImage: imageID!,  // Store the unique image ID in the post
                postLikes: 0,
                postComments: []
            )
            
            mockPosts.append(newPost)
            DataManager.shared.savePosts(mockPosts)  // Persist updated posts
        }
    @IBAction func postButtonTapped(_ sender: UIButton) {
        guard let currentUser = mockUsers.first else { return }  // Assuming first user is posting for demo
               guard let postText = postTextView.text, !postText.isEmpty else { return }
               
               let image = postImage.image
               addNewPost(user: currentUser, text: postText, image: image)
               
        // Print the current user, post text, and image (if available)
            print("Current User: \(currentUser)")
            print("Post Text: \(postText)")
            if let image = image {
                print("Image: \(image)")
            } else {
                print("No Image")
            }
               // Reset UI after posting
               postTextView.text = ""
               postImage.image = UIImage(named: "placeholder")  // Reset to placeholder image
               placeHolderLabel.isHidden = false
        dismiss(animated: true, completion: nil)
        
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
