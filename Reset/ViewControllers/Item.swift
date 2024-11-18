//
//  Item.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//


import Foundation
import UIKit

enum ItemType {
    case text
    case image
}

struct Item {
    var type: ItemType
    var text: String?
    var image: UIImage?
}
