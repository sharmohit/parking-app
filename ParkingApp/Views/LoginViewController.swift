//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  LoginViewController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 13/05/21.
//

import UIKit
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginViewController")
        
        self.fetchFirebaseData()
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var stayLoginSwitch: UISwitch!
    
    @IBAction func loginButtonWasTapped(_ sender: UIButton) {
        print("Login button tapped")
    }
    
    @IBAction func createAccountWasTapped(_ sender: UIButton) {
        print("Create account button tapped")
    }
    
    func fetchFirebaseData() {
        
        do {
            
            try db.collection("users").getDocuments(completion: { (queryResults, error) in
                
                if let err = error {
                    print("Error occured in Firestore \(err)")
                } else if queryResults!.documents.count == 0 {
                    print("No records found in Users")
                } else {
                    for result in queryResults!.documents {
                        print(result.data())
                    }
                }
            })
            
        } catch {
            print(error)
        }
    }
}
