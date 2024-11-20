//
//  BadgeCardCell.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//

import Foundation

import UIKit

class BadgeCardCell: UITableViewCell {
    // Badge image
    let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    // Badge name label
    let badgeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    // Badge duration label
    let badgeDurationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCellUI() {
        // Add subviews
        contentView.addSubview(badgeImageView)
        contentView.addSubview(badgeNameLabel)
        contentView.addSubview(badgeDurationLabel)

        // Enable Auto Layout
        badgeImageView.translatesAutoresizingMaskIntoConstraints = false
        badgeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeDurationLabel.translatesAutoresizingMaskIntoConstraints = false

        // Add constraints
        NSLayoutConstraint.activate([
            // Badge Image
            badgeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            badgeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            badgeImageView.widthAnchor.constraint(equalToConstant: 50),
            badgeImageView.heightAnchor.constraint(equalToConstant: 50),

            // Badge Name Label
            badgeNameLabel.leadingAnchor.constraint(equalTo: badgeImageView.trailingAnchor, constant: 16),
            badgeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            badgeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Badge Duration Label
            badgeDurationLabel.leadingAnchor.constraint(equalTo: badgeImageView.trailingAnchor, constant: 16),
            badgeDurationLabel.topAnchor.constraint(equalTo: badgeNameLabel.bottomAnchor, constant: 4),
            badgeDurationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            badgeDurationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}

