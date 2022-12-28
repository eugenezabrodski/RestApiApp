//
//  NewPostVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 28.12.22.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewPostVC: UIViewController {
    
    var user: User?

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func urlAction() {
        if let userId = user?.id,
           let title = titleTF.text,
           let text = bodyTV.text,
           let url = ApiConstants.postPathURL {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let post: [String: Any] = ["userId": userId, "title": title, "body": text]
            
            let httpBody = try? JSONSerialization.data(withJSONObject: post, options: [])
            request.httpBody = httpBody
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response ?? "")
                if let data = data {
                    print(data)
                    let json = JSON(data)
                    print(json)
                    let userId = json["userId"].int
                    let title = json["title"].string
                    let bode = json["body"].string
                    
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                    } else if let error = error {
                        print(error)
                }
            }.resume()
        }
    }
    
    @IBAction func alamofireAction(_ sender: Any) {
        if let userId = user?.id,
           let title = titleTF.text,
           let text = bodyTV.text,
           let url = ApiConstants.postPathURL {
            
            let parameters: Parameters = ["userId": userId, "title": title, "body": text]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                
                debugPrint(response)
                debugPrint(response.result)
                
                switch response.result {
                case .success(let data):
                    self.navigationController?.popViewController(animated: true)
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
