//
//  CommentsTVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 25.12.22.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    // MARK: - Methods
    
    var post: Post?
    var comments: [Comment] = []
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comments = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        cell.textLabel?.text = comments.email
        cell.detailTextLabel?.text = comments.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - Methods
    
    func fetchPosts() {
        guard let postId = post?.id else { return }
        let pathURL = "\(ApiConstants.commentsPath)?postId=\(postId)"
        
        guard let url = URL(string: pathURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: data)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
