//
//  NetworkService.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 28.12.22.
//

import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class NetworkService {
    
    static func deletePost(postID: Int, callback: @escaping (_ result: JSON?, _ error: Error?) -> Void) {
        let url = ApiConstants.postPath + "/" + "\(postID)"
        
        AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            var jsonValue: JSON?
            var err: Error?
            
            switch response.result {
            case .success(let data):
                jsonValue = JSON(data)
            case .failure(let error):
                err = error
            }
            callback(jsonValue, err)
        }
    }
    
    static func getPhotos(albumId: Int, callback: @escaping (_ result: [JSON]?, _ error: Error?) -> Void) {
        let url = ApiConstants.photosPath + "?" + "albumID=\(albumId)"
        
        AF.request(url).response { response in
            var jsonValue: [JSON]?
            var err: Error?
            
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                jsonValue = JSON(data).arrayValue
            case .failure(let error):
                err = error
            }
            callback(jsonValue, err)
        }
    }
    
    static func getPhoto(imageURL: String, callback: @escaping (_ result: UIImage?, _ error: AFError?) -> Void) {
        if let image = CacheManager.shared.imageCache.image(withIdentifier: imageURL) {
            callback(image, nil)
        } else {
            AF.request(imageURL).responseImage { response in
                if case .success(let image) = response.result {
                    
                    CacheManager.shared.imageCache.add(image, withIdentifier: imageURL)
                    callback(image, nil)
                } 
            }
        }
    }

}
