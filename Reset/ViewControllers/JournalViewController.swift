//
//  JournalViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 12/11/24.
//
import UIKit

class JournalViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var journals: [Journal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadJournals()
    }
    
    private func setupNavigationBar() {
        title = "Journal"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addJournalButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(JournalCollectionViewCell.self, forCellWithReuseIdentifier: JournalCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadJournals() {
        journals = JournalManager.shared.getAllJournals()
        collectionView.reloadData()
    }
    
    @objc private func addJournalButtonTapped() {
        let noteVC = NoteViewController()
        noteVC.delegate = self
        let navController = UINavigationController(rootViewController: noteVC)
        present(navController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension JournalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return journals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JournalCollectionViewCell.identifier, for: indexPath) as! JournalCollectionViewCell
        cell.configure(with: journals[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 300)
    }
}

// MARK: - NoteViewControllerDelegate
extension JournalViewController: NoteViewControllerDelegate {
    func didFinishSavingJournal() {
        loadJournals()
        if let latestJournal = journals.first {
            print("\nLatest Journal Entry:")
            print("ID: \(latestJournal.id)")
            print("Date: \(latestJournal.date)")
            print("Title: \(latestJournal.title)")
            print("Content: \(latestJournal.content)")
            print("Number of Images: \(latestJournal.imageData.count)")
        }
    }
}
