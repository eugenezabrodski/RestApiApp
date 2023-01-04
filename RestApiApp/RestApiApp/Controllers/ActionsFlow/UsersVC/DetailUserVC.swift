//
//  DetailUserVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 25.12.22.
//

import UIKit

class DetailUserVC: UIViewController {
    
    //MARK: - Properties
    
    var user: User?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    
    //MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Metods
    
    @IBAction func adressAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Adress", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func postsAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as! PostsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func albumsAction() {
        let storyboard = UIStoryboard(name: "Albums", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlbumsTVC") as! AlbumsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func todosAction() {
    }
    
    private func setupUI() {
        name.text = user?.name
        username.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
        website.text = user?.website
    }

}
