//
//  signUpViewController.swift
//  Soundsgram
//
//  Created by Hasan Dagg on 18.12.2019.
//  Copyright © 2019 Hasan Dag. All rights reserved.
//

import UIKit
import Firebase


class signUpViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var logo2: UIImageView!
    @IBOutlet weak var passwordAgainText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        if emailText.text != "" && (passwordText.text == passwordAgainText.text) && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    
                    //username ile kayıt almak icin dtabase managment yap
                    let FireStorem = Firestore.firestore()
                    let kayitBilgileri = ["Email" : self.emailText.text, "Username" : self.usernameText.text, "Password" : self.passwordText.text, "UID":Auth.auth().currentUser?.uid, "Feeds": String(0), "Followers": String(0), "Follows":String(0)] as [String : Any]
                    FireStorem.collection("UserInfo").document(self.usernameText.text!).setData(kayitBilgileri) { (Error) in
                        Error?.localizedDescription
                    }
                    
                    self.performSegue(withIdentifier: "toMainVC", sender: nil)
                    
                }
            }
        
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Please enter corretly to areas?")
        }
        
        
        
        
        
        
        performSegue(withIdentifier: "toMainVC", sender: nil)

    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
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
