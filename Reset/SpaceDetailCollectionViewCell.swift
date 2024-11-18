//
//  SpaceDetailCollectionViewCell.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//

import UIKit

class SpaceDetailCollectionViewCell: UICollectionViewCell {
    static let identifier = "SpeakerCell"
    
    // ImageView for speaker
    let speakerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25 // For 50x50 image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Label for speaker name
    let speakerName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Add subviews
        contentView.addSubview(speakerImage)
        contentView.addSubview(speakerName)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Image constraints
            speakerImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            speakerImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speakerImage.widthAnchor.constraint(equalToConstant: 50),
            speakerImage.heightAnchor.constraint(equalToConstant: 50),
            
            // Label constraints
            speakerName.topAnchor.constraint(equalTo: speakerImage.bottomAnchor, constant: 8),
            speakerName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            speakerName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            speakerName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            speakerName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with speaker: User) {
        speakerImage.image = UIImage(named: "shirts")
        speakerName.text = speaker.name
    }
    
    // Reset the cell when it's reused
    override func prepareForReuse() {
        super.prepareForReuse()
        speakerImage.image = nil
        speakerName.text = nil
    }
}
