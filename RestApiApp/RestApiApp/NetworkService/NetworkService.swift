//
//  NetworkService.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 28.12.22.
//

import Foundation
import Alamofire
import SwiftyJSON

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
}
