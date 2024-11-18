//
//  NotViewController.swift
//  Journalll
//
//  Created by Prasanjit on 18/11/24.
//

import UIKit
protocol NoteViewControllerDelegate: AnyObject {
    func didFinishSavingJournal()
}

class NoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UICollectionViewDataSource {

    // MARK: - UI Elements
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    private let titleField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Padding inside the text view
        return textView
    }()

    private lazy var addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal) // SF Symbol
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(addImagesTapped), for: .touchUpInside)
        return button
    }()

    private let addImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Images"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()

    private var collectionView: UICollectionView!

    // Data Source for Collection View
    private var images: [UIImage] = []

    // Keyboard variables
    private var keyboardHeight: CGFloat = 0
    
    weak var delegate: NoteViewControllerDelegate?
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupKeyboardNotifications()
        initializeCurrentDate()

        // Add "Done" button to navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        // Set the text view delegate
        textView.delegate = self
    }

    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }

    // MARK: - Setup Methods
    private func setupViews() {
        // Add UI elements to the view
        view.addSubview(dateLabel)
        view.addSubview(titleField)
        view.addSubview(textView)
        view.addSubview(addImageButton)
        view.addSubview(addImageLabel)

        // Setup collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10

        // Create and add the collection view
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        // Disable autoresizing masks
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        addImageLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        // Add constraints
        NSLayoutConstraint.activate([
            // Date Label
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Title Field
            titleField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Text View
            textView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 200),

            // Collection View
            collectionView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 120),

            // Add Image Button
            addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addImageButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -60),
            addImageButton.heightAnchor.constraint(equalToConstant: 50),
            addImageButton.widthAnchor.constraint(equalToConstant: 50),

            // Add Image Label
            addImageLabel.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 5),
            addImageLabel.centerXAnchor.constraint(equalTo: addImageButton.centerXAnchor)
        ])
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func initializeCurrentDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        dateLabel.text = formatter.string(from: Date())
    }

    // MARK: - Keyboard Handling
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        keyboardHeight = keyboardFrame.height
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: keyboardHeight + 10, right: 10)
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }

    @objc private func keyboardWillHide(notification: Notification) {
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.scrollIndicatorInsets = textView.contentInset
    }

    // MARK: - UITextView Delegate
    func textViewDidChange(_ textView: UITextView) {
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }

    // MARK: - Add Image Action
    @objc private func addImagesTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }

    // MARK: - Done Button Action
    @objc private func doneButtonTapped() {
        let title = titleField.text ?? ""
        let bodyText = textView.text ?? ""
        
        // Convert images to Data
        let imageDataArray = images.compactMap { image -> Data? in
            return image.jpegData(compressionQuality: 0.7)
        }
        
        // Create and save journal
        let journal = Journal(title: title, content: bodyText, imageData: imageDataArray)
        JournalManager.shared.saveJournal(journal)
        
        print("Saved Entry:")
        print("Title: \(title)")
        print("Body: \(bodyText)")
        print("Images Count: \(images.count)")
        
        // Clear the form
        titleField.text = ""
        textView.text = ""
        images.removeAll()
        collectionView.reloadData()
        
        // Notify delegate
        delegate?.didFinishSavingJournal()
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Image Picker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            images.append(image)
            collectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
}

// MARK: - Image Cell
class ImageCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

