import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    func configure(with item: Item) {
            // Show text if the item is a text type
            if item.type == .text {
                label.isHidden = false
                imageView.isHidden = true
                label.text = item.text
            } else if item.type == .image {
                label.isHidden = true
                imageView.isHidden = false
                imageView.image = item.image
            }
    }
}
