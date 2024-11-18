//
//  PostsViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 15/11/24.
//

import UIKit

class PostsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    var mockPosts: [Post] = DataManager.shared.loadPosts()
    override func viewDidLoad() {
        super.viewDidLoad()
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockPosts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postsCollectionView.dequeueReusableCell(withReuseIdentifier: "postcell", for: indexPath) as! PostsCollectionViewCell
        let post = mockPosts[indexPath.row]
        cell.userNameLabel.text = post.user.name
        cell.dateOfPostLabel.text = formatDate(post.postDate)
        cell.profileImage.image = UIImage(named: post.user.profileImage)
        cell.postImage.image = UIImage(named: post.postImage)
        cell.noOfLikesLabel.text = "\(post.postLikes)"
        cell.noOfCommentsLabel.text = "\(post.postComments.count)"
        cell.postTextLabel.text = "\(post.postText)"
        return cell
    }
    

    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPost = mockPosts[indexPath.row]
        print("Selected Post: \(selectedPost.postText)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
