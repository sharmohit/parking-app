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

class LoginViewController: UIViewController, FirestoreFetchDelegate {
    
    private var loginController = LoginController()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var stayLoginSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginController.user.delegate = self
        loginController.initiateLogin()
    }
    
    @IBAction func loginButtonWasTapped(_ sender: UIButton) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.isEmpty {
            showAlert(title: "Login Error", message: "An email is required")
            return
        }
        if !email.isValidEmail {
            showAlert(title: "Login Error", message: "Incorrect email")
            return
        }
        if password.isEmpty {
            showAlert(title: "Login Error", message: "Password is required")
            return
        }
        
        loginController.fetchUser(id: email, password: password)
    }
    
    func fetchCompleted(isError:Bool) {
        
        if isError {
            self.showAlert(title: "Login Error", message: "User not found")
            return
        }
        
        if loginController.login(isSaveLogin: self.stayLoginSwitch.isOn) {
            self.showHomeScreen()
        } else {
            self.showAlert(title: "Login Error", message: "Invaild credentials")
        }
    }
    
    @IBAction func createAccountWasTapped(_ sender: UIButton) {
        self.showCreateAccountScreen()
    }
    
    func showHomeScreen()
    {
        guard let parkingViewNVC = self.storyboard?.instantiateViewController(identifier: "Home") as? UITabBarController else{
            return
        }
        
        //let taskListVC = taskListNVC.viewControllers[0] as! ParkingTableViewController
        //taskListVC.currentUser = loginController.user
        parkingViewNVC.modalPresentationStyle = .fullScreen
        self.present(parkingViewNVC, animated:true)
    }
    
    func showCreateAccountScreen()
    {
        guard let createAccountVC = self.storyboard?.instantiateViewController(identifier: "CreateAccount") else{
            return
        }
        
        createAccountVC.modalPresentationStyle = .fullScreen
        self.present(createAccountVC, animated:true)
    }
    
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message:
                                                    message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
