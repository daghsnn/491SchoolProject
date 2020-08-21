//
//  myFeedTableViewCell.swift
//  Soundsgram
//
//  Created by Hasan Dagg on 19.12.2019.
//  Copyright © 2019 Hasan Dag. All rights reserved.
//

import UIKit
import Firebase
class myFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likebuton: UIButton!
    @IBOutlet weak var commentButon: UIButton!
    
    @IBOutlet weak var unlike: UIButton!
    @IBOutlet weak var documentIdlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func likebuton(_ sender: Any) {
       // self.likebuton.isEnabled = false
        let firestoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!){
            let likePost = ["Likes" : likeCount + 1] as [String : Any ]
            firestoreDatabase.collection("Feeds").document(documentIdlabel.text!).setData(likePost, merge: true)
            self.likebuton.isHidden = true
            self.unlike.isHidden = false
           self.likebuton.isEnabled = true
            }
        }
        
    @IBAction func unLikebuton(_ sender: Any) {
        //unlike.isEnabled = false
        let firestoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!){
            let likePost = ["Likes" : likeCount - 1] as [String : Any ]
            firestoreDatabase.collection("Feeds").document(documentIdlabel.text!).setData(likePost, merge: true)
            self.likebuton.isHidden = false
            self.unlike.isHidden = true
            self.likebuton.isEnabled = true
        }
    
    }
    @IBAction func commenbutton(_ sender: Any) {
    }
    //like saymak icin
    
}
