//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  LoginController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 19/05/21.
//

import Foundation

class LoginController {
    
    private let defaults = UserDefaults.standard
    
    var email:String
    var password:String
    var user = User.getInstance()
    
    init() {
        self.email = ""
        self.password = ""
    }
    
    func initiateLogin() {
        
        let email = defaults.string(forKey:"email") ?? ""
        let password = defaults.string(forKey:"pass") ?? ""
        if !email.isEmpty &&
            !password.isEmpty {
            fetchUser(id: email, password: password)
        }
    }
    
    func fetchUser(id:String, password:String) {
        self.email = id
        self.password = password
        self.user.fetchUserData(id: self.email)
    }
    
    func login (isSaveLogin:Bool) -> Bool {
        
        if self.user.password == self.password {
            if isSaveLogin {
                defaults.set(self.email, forKey:"email")
                defaults.set(self.password, forKey:"pass")
            }
            return true
        }
        
        return false
    }
}
