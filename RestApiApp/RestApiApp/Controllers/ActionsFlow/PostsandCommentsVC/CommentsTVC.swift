//
//  CommentsTVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 25.12.22.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    var post: Post?
    var comments: [Comment] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
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
