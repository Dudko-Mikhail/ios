//
//  Comment.swift
//  AlamofireDemo
//
//  Created by Artyom on 8.05.21.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
