//
//  PostsTVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 25.12.22.
//

import UIKit

class PostsTVC: UITableViewController {
    
    var user: User?
    var posts: [Post] = []
    var comments: [Comment] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CommentsTVC") as! CommentsTVC
        vc.post = posts[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchPosts() {
        guard let userId = user?.id else { return }
        let pathURL = "\(ApiConstants.postPath)?userId=\(userId)"
        
        guard let url = URL(string: pathURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data)
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
