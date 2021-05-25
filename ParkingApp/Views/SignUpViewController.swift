
//  Group: Project Groups 12
//  Name: Javtesh Singh
//  Student ID: 101348129
//  Group Member: Mohit Sharma
//  Member ID: 101342267

//  SignUpViewController.swift
//  ParkingApp
//
//  Created by Javtesh Singh on 13/05/21.
//

import UIKit
import FirebaseFirestore



class SignUpViewController: UIViewController {
    
    let db = Firestore.firestore()
    var theEmail = ""
    
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etEmail: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var etMobileNumber: UITextField!
    @IBOutlet weak var etCarPlateNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Viewing SignUp Screen")
       
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        let name = etName.text
        let email = etEmail.text
        let pass = etPassword.text
        let mobileNo = etMobileNumber.text
        let carPlateNo = etCarPlateNumber.text
        let id = ""
        
        
        if (name!.isEmpty || email!.isEmpty || pass!.isEmpty || mobileNo!.isEmpty || carPlateNo!.isEmpty) {
                    let errorEmpty = "You must enter all required fields. "
                    createAlert(errorName: errorEmpty)
                }
        else if ((email?.isValidEmail) == false){
            let errorEmail = "Email ID is invalid"
            createAlert(errorName: errorEmail)
        }
        
        else if carPlateNo?.count != 5 {
            let errorCarPlate = "Please enter valid 5 digit Car Plate Number"
            createAlert(errorName: errorCarPlate)
        }
        
        else {
            
            
            theEmail = email!
            
            print("Setting all values in User file")
            
            User.getInstance().name = name!
            User.getInstance().email = email!
            User.getInstance().password = pass!
            User.getInstance().phone = mobileNo!
            User.getInstance().carPlateNumber = carPlateNo!
            
            let userInfo = [
                "name" : name,
                "email" : email,
                "password" : pass,
                "phone" : mobileNo,
                "car_plate_number" : carPlateNo
                    ]
            
            db.collection("users").addDocument(data: userInfo){ (error ) in
                
                print("Uploading user info to the firestore ... ")
                
                if let err = error{
                    print("error when saving documnet")
                    print(err)
                    return
                }
                else {
                    print("User info saved successfully to the fireStore.")
                    self.getId()
                    self.movingToHomeScreen()
                }
                
            }
        }
    }
    
    
    func getId(){
        db.collection("users").whereField("email", isEqualTo: theEmail)
            .getDocuments { queryResults, error in
            
            if let err = error {
                print("Error getting documents from student collection")
                print(err)
                return
                
            }
            
            else {
                // we were successful in getting the docs.
                if (queryResults!.count == 0){
                    print("No results found")
                }
                else {
                    // we found some results
                    for result in queryResults!.documents {
                        print("We got id of document as : \(result.documentID)")
                        User.getInstance().id = result.documentID
    }
}
            }
            }
    }
        
    func createAlert(errorName:String) {
        let alert = UIAlertController(title: "Error", message: errorName, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: " OK ", style: .cancel, handler: {
                                        action in print("tapped OK")}) )
        present(alert,animated: true)
    }
    
    func movingToHomeScreen () {
        print("Moving to HomeScreen")
        guard let s1 = storyboard?.instantiateViewController(identifier: "Home") as? HomeViewController else {
        print("Screen not found")
        return
        }
        
        s1.modalPresentationStyle = .fullScreen
        self.present(s1, animated: true)
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        
        print("Moving to Login Screen")
        guard let s1 = storyboard?.instantiateViewController(identifier: "login") as? LoginViewController else {
        print("Screen not found")
        return
        }
        
        s1.modalPresentationStyle = .fullScreen
        self.present(s1, animated: true)
        
    }
    
}
