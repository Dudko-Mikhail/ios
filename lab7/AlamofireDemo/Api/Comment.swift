//
//  Comment.swift
//  AlamofireDemo
//
//  Created by Ivan on 13.05.21.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
