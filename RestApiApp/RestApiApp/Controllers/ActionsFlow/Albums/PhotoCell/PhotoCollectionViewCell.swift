//
//  PhotoCollectionViewCell.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 2.01.23.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var degaultImage: UIImageView!    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var thumbnailUrl: String? {
        didSet {
            getThumbnail()
        }
    }
    
    // MARK: - Life cicle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    
    private func getThumbnail() {
        guard let thumbnailUrl = thumbnailUrl else { return }
        
        NetworkService.getPhoto(imageURL: thumbnailUrl) { [weak self] image, error in
            self?.activityIndicator.stopAnimating()
            self?.degaultImage.image = image
        }
    }

}
