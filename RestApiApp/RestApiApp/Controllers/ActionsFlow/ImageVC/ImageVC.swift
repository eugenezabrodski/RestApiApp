//
//  ImageVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 21.12.22.
//

import UIKit

class ImageVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let imageURL = "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = URL(string: imageURL) else { return }
        let uRLRequest = URLRequest(url: url)
        
        
        let data = URLSession.shared.dataTask(with: uRLRequest) { data, urlResponse, error in
            
            DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = urlResponse {
                print(response)
            }
            
            print("\n", data ?? "", "\n")
            
            if let data = data, let image = UIImage(data: data) {
                self.image.image = image
            } else {
                
            }
        }
        }
        data.resume()
        
}

}
