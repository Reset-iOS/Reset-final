//
//  SpeakerCollectionViewCell.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//

import UIKit

class SpeakerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    static let identifier = "SpeakerCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    
    public func configure(with speaker:User) {
        print(speaker.name)
        userName.text = speaker.name
        profileImage.image = UIImage(named: speaker.profileImage)
    }
    
    static func nib() -> UINib {
        UINib(nibName: "SpeakerCollectionViewCell", bundle: nil)
    }

}
