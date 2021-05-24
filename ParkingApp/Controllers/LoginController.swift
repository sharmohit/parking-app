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

public protocol LoginDelegate {
    func loginDidSuccess()
    func loginDidFailed(error:String)
}

class LoginController {
    
    private let defaults = UserDefaults.standard
    var delegate:LoginDelegate?
    
    private var user = User.getInstance()
    private var email:String
    private var password:String
    
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
            print(self.email,self.user.email,self.password,self.user.password)
        }
    }
    
    func fetchUser(id:String, password:String) {
        self.email = id
        self.password = password
        self.user.fetchUser(id: self.email){
            (error) in
            
            if let error = error {
                self.delegate?.loginDidFailed(error: error)
            } else {
                self.delegate?.loginDidSuccess()
            }
        }
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
