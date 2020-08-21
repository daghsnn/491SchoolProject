//
//  FeedViewController.swift
//  Soundsgram
//
//  Created by Hasan Dagg on 18.12.2019.
//  Copyright © 2019 Hasan Dag. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var userNameArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    let fireStoreDatabase = Firestore.firestore()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        tableView.delegate = self
        tableView.dataSource = self
        getFeeds()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myFeedTableViewCell //burada feedvc ye cellimizi tanitiyoruz ki icindeki herseyi gorebilsin
        cell.usernameLabel.text = userNameArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        // image yi firestore dan almak icin SDImage pods kullanıp url seklindeki tanımına fotografı yollama methodu github SDWebImage
        cell.userimg.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIdlabel.text = documentIdArray[indexPath.row]//id yi burdan alip myFeedTableVC de okutuyoruz comment icinde aynı update gerekicek
        return cell
    }
    func getFeeds() {
        let fireStoreDatabasem = Firestore.firestore()

        fireStoreDatabasem.collection("Feeds").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userNameArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        let documentId = document.documentID
                        self.documentIdArray.append(documentId)

                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userNameArray.append(postedBy)
                        }
                        if let imgUrlArray = document.get("postUrl") as? String {
                            self.userImageArray.append(imgUrlArray)

                        }
                     
                        if let likes = document.get("Likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let postComment = document.get("Comments") as? String{
                            self.userCommentArray.append(postComment)
                        }
                                            
                   }
                     self.tableView.reloadData()
                
               

                }
            }
        }
    }
    
    func getUserInfo() {
        
        fireStoreDatabase.collection("UserInfo").whereField("Email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let username = document.get("Username") as? String {
                            //soundsgramUser.kullanicilar.email = Auth.auth().currentUser!.email!
                            soundsgramUser.kullanicilar.username = username
                        }
                        if let feedCount = document.get("Feeds") as? String {
                            soundsgramUser.kullanicilar.userFeedcount = Int(feedCount)!
                        }
                        
                        if let followers = document.get("Followers") as? String {
                            soundsgramUser.kullanicilar.followers = Int(followers)!
                        }
                        
                        if let follows = document.get("Follows") as? String {
                            soundsgramUser.kullanicilar.follows = Int(follows)!
                        }
                    }
                }
            }
        }
        
    }
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
    }

}
