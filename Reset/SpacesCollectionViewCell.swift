//
//  SpacesCollectionViewCell.swift
//  Reset
//
//  Created by Prasanjit Panda on 17/11/24.
//

import UIKit

class SpacesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var spacesTitleLabel: UILabel!
    
    @IBOutlet weak var spaceHostLabel: UILabel!
    
    @IBOutlet weak var spaceDescriptionLabel: UILabel!
    
    @IBOutlet weak var listeningAndLiveLabel: UILabel!
    
    func configure(with model: SpacesModel) {
        spacesTitleLabel.text = model.title
        spaceHostLabel.text = model.hostedBy
        spaceDescriptionLabel.text = model.description
        listeningAndLiveLabel.text = "\(model.listeners) listening | \(model.duration)"
    }
    
}
