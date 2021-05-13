//
//  SignUpViewController.swift
//  ParkingApp
//
//  Created by Javtesh Singh on 13/05/21.
//

import UIKit

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etEmail: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var etMobileNumber: UITextField!
    @IBOutlet weak var etCarPlateNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SignUp Screen Launched")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        let name = etName.text ?? ""
        let email = etEmail.text ?? ""
        let pass = etPassword.text ?? ""
        let mobileNo = etMobileNumber.text ?? ""
        let carPlateNo = etCarPlateNumber.text ?? ""
        
        print("The name entered is \(name) and has email id \(email) with password \(pass) and Mobile Number as \(mobileNo). \nThe car plate No. is : \(carPlateNo) ")
        
    }
    

}


