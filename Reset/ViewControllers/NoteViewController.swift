import UIKit

class NoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UI Elements
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Wednesday, 25 Sep"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = true
        textView.text = "Start typing..."
        textView.textColor = .lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let bottomToolbar: UIStackView = {
        let logButton = UIButton()
        logButton.setImage(UIImage(systemName: "waveform"), for: .normal)
        logButton.setTitle("Log urges", for: .normal)
        logButton.setTitleColor(.gray, for: .normal)
        logButton.tintColor = .gray
        logButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        logButton.centerTextAndImage(spacing: 4)
        
        let recordButton = UIButton()
        recordButton.setImage(UIImage(systemName: "waveform.circle"), for: .normal)
        recordButton.setTitle("Record audio", for: .normal)
        recordButton.setTitleColor(.gray, for: .normal)
        recordButton.tintColor = .gray
        recordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        recordButton.centerTextAndImage(spacing: 4)
        
        let imageButton = UIButton()
        imageButton.setImage(UIImage(systemName: "photo"), for: .normal)
        imageButton.setTitle("Add images", for: .normal)
        imageButton.setTitleColor(.gray, for: .normal)
        imageButton.tintColor = .gray
        imageButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        imageButton.centerTextAndImage(spacing: 4)
        
        // Add action for adding images
        imageButton.addTarget(self, action: #selector(addImageTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [logButton, recordButton, imageButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var selectedImages: [UIImage] = [] // To store selected images
    private var imageViews: [UIImageView] = [] // To store corresponding UIImageViews
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        setupKeyboardHandling()
        
        textView.delegate = self
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        view.addSubview(dateLabel)
        view.addSubview(textView)
        view.addSubview(bottomToolbar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Date Label
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Text View
            textView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Bottom Toolbar
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bottomToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomToolbar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        bottomToolbar.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        bottomToolbar.transform = .identity
    }
    
    // MARK: - Image Picker Methods
    @objc private func addImageTapped() {
        // Check if the photo library is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true  // Allow editing (optional)
            present(picker, animated: true, completion: nil)
        }
    }
    
    // UIImagePickerControllerDelegate method to handle image selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the selected image
        if let image = info[.originalImage] as? UIImage {
            selectedImages.append(image)  // Store the selected image
            displaySelectedImages()  // Update the UI to display the selected image
        }
        dismiss(animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate method if the user cancels
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Method to display selected images above the text view
    private func displaySelectedImages() {
        // Clear existing image views
        for imageView in imageViews {
            imageView.removeFromSuperview()
        }
        
        imageViews.removeAll()  // Reset the array of imageViews
        
        var previousImageView: UIImageView? = nil
        
        for image in selectedImages {
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            imageViews.append(imageView)
            
            // Set constraints for the image views
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                imageView.heightAnchor.constraint(equalToConstant: 200)
            ])
            
            if let previous = previousImageView {
                // Place this image view below the previous one
                imageView.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 16).isActive = true
            } else {
                // Place the first image view below the date label
                imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true
            }
            
            previousImageView = imageView
        }
        
        // Adjust the text view position
        if let lastImageView = imageViews.last {
            textView.topAnchor.constraint(equalTo: lastImageView.bottomAnchor, constant: 16).isActive = true
        }
    }
}

// MARK: - UITextViewDelegate
extension NoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Start typing..." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Start typing..."
            textView.textColor = .lightGray
        }
    }
}

// MARK: - UIButton Extension for Text and Image Centering
extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        // Use UIButton's configuration API
        var config = UIButton.Configuration.plain()
        config.imagePadding = spacing
        self.configuration = config
        
        // Set content insets to keep everything centered
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        
        // Align image and text
        self.imageView?.contentMode = .scaleAspectFit
        self.titleLabel?.textAlignment = .center
    }
}
