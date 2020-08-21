//
//  UploadViewController.swift
//  Soundsgram
//
//  Created by Hasan Dagg on 18.12.2019.
//  Copyright © 2019 Hasan Dag. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!

    @IBOutlet weak var openCamera: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
      
    }

    
    @objc func chooseImage() {
           
        
        let picker = UIImagePickerController()
        picker.delegate = self
        if openCamera.isTouchInside == true {
            picker.sourceType = .camera
            
        }
        if imageView.isUserInteractionEnabled == true {
            picker.sourceType = .photoLibrary
            
        }
        picker.mediaTypes = ["public.image", "public.movie"]
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        

           imageView.image = info[.originalImage] as? UIImage
           self.dismiss(animated: true, completion: nil) }
    
    
    
    @IBAction func uploadbtn(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("Feeds")
        
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            //Firestore
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["postUrl" : imageUrl!, "postedBy" : soundsgramUser.kullanicilar.username, "Comments" : self.commentText.text!,"date" : FieldValue.serverTimestamp(), "Likes" : 0 ] as [String : Any]

                            firestoreReference = firestoreDatabase.collection("UserInfo").document(soundsgramUser.kullanicilar.username).collection("userFeeds").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                    
                                } else {
                                    
                                    self.imageView.image = UIImage(named: "uploadimg1.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                 }
                                                              })
                                                              
                                //ayrıca feedse koymak icin
                            let firestoreFeeds = Firestore.firestore()
                            var firestoreFedRef : DocumentReference? = nil
                            let fireFeeds = ["postUrl" : imageUrl!, "postedBy" : soundsgramUser.kullanicilar.username, "Comments" : self.commentText.text!,"date" : FieldValue.serverTimestamp(), "Likes" : 0] as [String : Any]
                            firestoreFedRef = firestoreFeeds.collection("Feeds").addDocument(data: fireFeeds)
                            
                           
                            
                                                            
                        }
                                                          
                                                          
                                                      }
                                                      
                                                  }
                                              }
                                              
                                              
                                          }
                           
        soundsgramUser.kullanicilar.userFeedcount += 1
        
    }
                            
   
                            
                            
                            
                            
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

