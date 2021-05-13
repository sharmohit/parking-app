//
//  LoginViewController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 13/05/21.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("LoginViewController")
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
}
