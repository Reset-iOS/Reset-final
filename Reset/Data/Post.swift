//
//  Post.swift
//  Reset
//
//  Created by Prasanjit Panda on 14/11/24.
//

import Foundation

struct Post:Codable{
    var user:User
    var postDate:Date
    var postText:String
    var postImage:String
    var postLikes:Int
    var postComments:[String]
}


