//
//  ActionsCVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 21.12.22.
//

import UIKit

//MARK: - Enums

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case users = "Users"
}

class ActionsCVC: UICollectionViewController {
    
    // MARK: - Properties
    
    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases

    // MARK: - UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ActionCollectionViewCell else { return UICollectionViewCell() }
        
        cell.infoLabel.text = userActions[indexPath.row].rawValue
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "downloadImageSegue", sender: nil)
        case .users: performSegue(withIdentifier: "usersSegue", sender: nil)
        }

    }

}

// MARK: - Extensions

extension ActionsCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (UIScreen.main.bounds.width - 20), height: 80)
    }
}
