//
//  ModelsPostsAndComments.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 26.12.22.
//

import UIKit

struct Post: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

struct Comment: Codable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
