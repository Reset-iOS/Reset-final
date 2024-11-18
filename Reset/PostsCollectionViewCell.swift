//
//  PostsCollectionViewCell.swift
//  Reset
//
//  Created by Prasanjit Panda on 15/11/24.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateOfPostLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var likesButton: UIButton!
    
    @IBOutlet weak var noOfCommentsLabel: UILabel!
    
    @IBOutlet weak var noOfLikesLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            profileImage.layer.cornerRadius = profileImage.frame.height / 2
            profileImage.clipsToBounds = true
        
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            postImage.widthAnchor.constraint(equalToConstant: 393), // Replace with desired width
            postImage.heightAnchor.constraint(equalToConstant: 200), // Replace with desired height
        ])

    }
}
