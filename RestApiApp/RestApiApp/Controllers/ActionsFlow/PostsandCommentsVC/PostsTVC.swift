//
//  PostsTVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 25.12.22.
//

import UIKit

class PostsTVC: UITableViewController {
    
    //MARK: - Properties
    
    var user: User?
    var posts: [Post] = []
    var comments: [Comment] = []
    
    //MARK: - Life cicle
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    // MARK: - Table view data source
    
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let id = posts[indexPath.row].id {
            NetworkService.deletePost(postID: id) { [weak self] json, error in
                if json != nil {
                    self?.posts.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } else if let error = error {
                    print(error)
                }
            }
        }
    }
    
    // MARK: - Table view delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CommentsTVC") as! CommentsTVC
        vc.post = posts[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Methods
    
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
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewPostVC {
            vc.user = user
        }
    }
    
}
