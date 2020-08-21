//
//  ProfileViewController.swift
//  Soundsgram
//
//  Created by Hasan Dagg on 18.12.2019.
//  Copyright © 2019 Hasan Dag. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var userImageArray = [String]()
    var documentIdArray = [String]()
    var likeArray = [Int]()
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feedcount: UILabel!
    @IBOutlet weak var followsCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    let fireStoreDatabase = Firestore.firestore()


    @IBOutlet weak var usernameText: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentIdArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! profileCellTableViewCell
        cell1.docIDlabel.text = documentIdArray[indexPath.row]
           cell1.ownFeedsImg.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
           cell1.likeCount.text = String(likeArray[indexPath.row])

           return cell1
       }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
        //getProfileData()
        usernameText.text = soundsgramUser.kullanicilar.username
        feedcount.text = String(documentIdArray.count)
        tableView.delegate = self
        tableView.dataSource = self
        
 
            }
    
    @IBAction func settingsBtn(_ sender: Any) {
        performSegue(withIdentifier: "toSettingsVC", sender: nil)
    }
  
    func getProfile(){
            let fireStoreDatabasem = Firestore.firestore()
        
        fireStoreDatabasem.collection("Feeds").whereField("postedBy", isEqualTo:soundsgramUser.kullanicilar.username).order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                       self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "Error")
                   }else{
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                                           
                        let documentId = document.documentID
                        self.documentIdArray.append(documentId)
                    
                        if let imgUrlArray = document.get("postUrl") as? String {
                            self.userImageArray.append(imgUrlArray)}
                        if let likes = document.get("Likes") as? Int{
                            self.likeArray.append(likes)
                            
                            
                        }
                    }
                    self.tableView.reloadData()

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

   /* func getProfileData(){
        let fireStoreDatabasem = Firestore.firestore()

        let docRef = fireStoreDatabasem.collection("UserInfo").document(soundsgramUser.kullanicilar.username).collection("userProfile").addSnapshotListener { (getsnap, error) in
            if error != nil {
                           self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                if getsnap != nil {
                    
                    let docs = getsnap?.documents
                    if let docurl = docs?.first?.get("profilePhoto") as? String
                    {
                        self.profilePhoto.sd_setImage(with: URL(string: docurl))
                        print(docurl)
                }
        }
            }
            
        }
        
    } */
    
}
/*
 // MARK:
    }
               
}
               
- Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


