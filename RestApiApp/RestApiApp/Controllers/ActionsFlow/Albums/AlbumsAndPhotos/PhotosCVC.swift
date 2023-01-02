//
//  PhotosCVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 2.01.23.
//

import UIKit
import SwiftyJSON


class PhotosCVC: UICollectionViewController {
    
    var user: User!
    var album: JSON!
    var photos: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        title = album["title"].string
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let sizeWH = (UIScreen.main.bounds.width / 2) - 5
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }


    // MARK: UICollectionViewDataSource



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let thumbnailUrl = photos[indexPath.row]["thumbnailUrl"].string
        cell.thumbnailUrl = thumbnailUrl
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPhoto", sender: photos[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoVC = segue.destination as? PhotoVC,
           let photo = sender as? JSON {
            photoVC.photo = photo
        }
    }
    
    private func getData() {
        guard let album = album,
        let albumId = album["id"].int
        else { return }
        NetworkService.getPhotos(albumId: albumId) { [weak self] result, error in
            guard let photos = result else { return }
            self?.photos = photos
            self?.collectionView.reloadData()
        }
    }

}
