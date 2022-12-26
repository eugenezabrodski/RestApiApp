//
//  Model Adress.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 26.12.22.
//

import UIKit

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Geo: Codable {
    let lat: String?
    let lng: String?
}
