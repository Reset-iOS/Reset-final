//
//  Journal.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//

import Foundation

struct Journal: Codable {
    let id: String
    let date: Date
    let title: String
    let content: String
    let imageData: [Data]  // Store image data
    
    init(id: String = UUID().uuidString,
         date: Date = Date(),
         title: String,
         content: String,
         imageData: [Data]) {
        self.id = id
        self.date = date
        self.title = title
        self.content = content
        self.imageData = imageData
    }
}
