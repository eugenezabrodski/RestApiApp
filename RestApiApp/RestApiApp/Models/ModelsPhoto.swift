//
//  ModelsPhoto.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 26.12.22.
//

import UIKit

struct Photo: Codable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
