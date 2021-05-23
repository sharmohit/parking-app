
//  Group: Project Groups 12
//  Name: Javtesh Singh
//  Student ID: 101348129
//  Group Member: Mohit Sharma
//  Member ID: 101342267

//  UpdateViewController.swift
//  ParkingApp
//
//  Created by Javtesh Singh on 16/05/21.
//

import UIKit
import FirebaseFirestore

class UpdateViewController: UIViewController {
    
    let db = Firestore.firestore()
    var theEmail = TheUser.userObject.email
    
    @IBOutlet weak var utName: UITextField!
    @IBOutlet weak var utEmail: UITextField!
    @IBOutlet weak var utPassword: UITextField!
    @IBOutlet weak var utMobileNumber: UITextField!
    @IBOutlet weak var utCarPlateNumber: UITextField!
    
    
    var userName: String = ""
    var userEmail: String = ""
    var userPassword: String = ""
    var userMobileNumber: String = ""
    var userCarPlateNumber: String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Update screen loaded ...")
        
        fetchingUserInfo()

        // Do any additional setup after loading the view.
    }
    
    
    func fetchingUserInfo(){
        print("Fetching user info")
  
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
                            print(result.documentID)
                            
                            TheUser.userObject.id = result.documentID
                            // print the data
                             print(result.data())
                            let row = result.data()
                            print(row["name"]!)
                            
                            self.userName = row["name"] as? String ?? "Name not available"
                            self.userEmail = row["email"] as? String ?? "Email not available"
                            self.userPassword = row["password"] as? String ?? "Password not available"
                            self.userMobileNumber = row["phone"] as? String ?? "Phone not available"
                            self.userCarPlateNumber = row["car_plate_number"] as? String ?? "car Plate not available"
                                                        
                            self.setUserData()
                        }
                    }
                }
            }
    }
    
    func setUserData(){
        
        
        utName.text = userName
        utEmail.text = userEmail
        utPassword.text = userPassword
        utMobileNumber.text = userMobileNumber
        utCarPlateNumber.text = userCarPlateNumber
        
        
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        print("Update Button Clicked")
 
        userName = utName.text ?? ""
        userEmail = utEmail.text ?? ""
        userPassword = utPassword.text ?? ""
        userMobileNumber = utMobileNumber.text ?? ""
        userCarPlateNumber = utCarPlateNumber.text ?? ""
        
        TheUser.userObject.name = userName
        TheUser.userObject.email = userEmail
        TheUser.userObject.pass = userPassword
        TheUser.userObject.mobileNo = userMobileNumber
        TheUser.userObject.carPlateNo = userCarPlateNumber
        
        
        
        var newUserInfo = [
        
            "name" : userName,
            "email" : userEmail,
            "password" : userPassword,
            "phone" : userMobileNumber,
            "car_plate_number" : userCarPlateNumber
        
        ]
        
        db.collection("users").document(TheUser.userObject.id).setData(newUserInfo)
        print("***********************")
        print("new values are : ")
        print("\(userName), \(userEmail),\(userPassword),\(userMobileNumber),\(userCarPlateNumber)")
        print("Data Saved")
        
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        
        print("Logout Button Clicked")
        
        print("Logging Out ...")
        
        TheUser.userObject.name = ""
        TheUser.userObject.email = ""
        TheUser.userObject.pass = ""
        TheUser.userObject.mobileNo = ""
        TheUser.userObject.carPlateNo = ""
        TheUser.userObject.id = ""
        
        
        movingToLoginScreen()
        
    }
    
    func movingToLoginScreen (){
        
            print("Moving to login Screen")
            guard let s1 = storyboard?.instantiateViewController(identifier: "login") as? LoginViewController else {
            print("Screen not found")
            return
            }
            
            s1.modalPresentationStyle = .fullScreen
            self.present(s1, animated: true)
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
      
        print("Delete button Tapped")
        
        confirmDeletition()
        
        
    }
    
    func confirmDeletition(){
        
        let refreshAlert = UIAlertController(title: "Confirm", message: "All Data will be deleted ", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("USER DLETITION : CONFIRMED")
            
            self.db.collection("users").document(TheUser.userObject.id).delete{ (error) in
                if error != nil {
                    print("There was an error while deleting the user info")
                }
                else{
                    print("user Deleted")
                    self.movingToLoginScreen()
                }
            }
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("USER DLETITION : CANCELLED")
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
}
    









