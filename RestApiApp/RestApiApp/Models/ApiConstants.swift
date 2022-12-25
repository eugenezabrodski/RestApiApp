//
//  ApiConstants.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 25.12.22.
//

import Foundation

class ApiConstants {
    static let serverPath = "http://localhost:3000/"
    
    static let postPath = serverPath + "posts"
    static let postPathURL = URL(string: postPath)
    
    static let commentsPath = serverPath + "comments"
    static let commentsPathURL = URL(string: commentsPath)
    
    static let albumsPath = serverPath + "albums"
    static let albumsPathURL = URL(string: albumsPath)
    
    static let photosPath = serverPath + "photos"
    static let photosPathURL = URL(string: photosPath)
    
}
