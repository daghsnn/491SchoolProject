//
//  userclass.swift
//  Soundsgram
//
//  Created by Hasan Dagg on 9.01.2020.
//  Copyright © 2020 Hasan Dag. All rights reserved.
//

import Foundation
import Firebase

class soundsgramUser {
    static let kullanicilar = soundsgramUser()
    
    
    var email = ""
    var username = ""
    var userFeedcount : Int = 0
    var followers : Int = 0
    var follows : Int = 0
    
    
    
    private init(){
        
    }
    
}
