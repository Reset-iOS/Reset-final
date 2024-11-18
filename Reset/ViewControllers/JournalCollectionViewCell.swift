//
//  JournalCollectionViewCell.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//

import UIKit
class JournalCollectionViewCell: UICollectionViewCell {
    static let identifier = "JournalCardCell"
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let imagesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(dateLabel)
        cardView.addSubview(imagesStackView)
        cardView.addSubview(titleLabel)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        imagesStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            
            imagesStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            imagesStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            imagesStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            imagesStackView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imagesStackView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with journal: Journal) {
        // Format date
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd MMM"
        dateLabel.text = formatter.string(from: journal.date)
        
        titleLabel.text = journal.title
        
        // Clear existing images
        imagesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add images (maximum 2)
        for (index, imageData) in journal.imageData.prefix(2).enumerated() {
            if let image = UIImage(data: imageData) {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 8
                imagesStackView.addArrangedSubview(imageView)
            }
        }
    }
}
