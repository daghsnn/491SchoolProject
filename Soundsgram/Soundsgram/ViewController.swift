//
//  ViewController.swift
//  Soundsgram
//
//  Created by Hasan Dagg on 18.12.2019.
//  Copyright © 2019 Hasan Dag. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signIn(_ sender: Any) {
    if emailText.text != "" && passwordText.text != "" {
        
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
            if error != nil {
                self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")

            } else {
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)

            }
        }
        
        
    } else {
        makeAlert(titleInput: "Error!", messageInput: "Please write corretly Mail or Password?")

    }
    
    }
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "tosignUpVC", sender: nil)
    
    
    }
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
    }
    
}

