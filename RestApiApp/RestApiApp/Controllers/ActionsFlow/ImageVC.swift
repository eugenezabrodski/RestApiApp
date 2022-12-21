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
        
    }

}
