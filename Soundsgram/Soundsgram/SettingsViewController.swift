//
//  SettingsViewController.swift
//  Soundsgram
//
//  Created by Hasan Dagg on 18.12.2019.
//  Copyright © 2019 Hasan Dag. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toMain2VC", sender: nil)
            
        } catch {
            print("error")
        }
        
    }
    
    @IBAction func settingsBack(_ sender: Any) {
        performSegue(withIdentifier: "toFeed2", sender: nil)
    }
    
   

}
