
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
    var theEmail = User.getInstance().email
    
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
        
        setUserData()

        // Do any additional setup after loading the view.
    }
    
    
    
    func setUserData(){
        
        print("Fetching user info")
        
        utName.text = User.getInstance().name
        utEmail.text = User.getInstance().email
        utPassword.text = User.getInstance().password
        utMobileNumber.text = User.getInstance().phone
        utCarPlateNumber.text = User.getInstance().carPlateNumber
        
        
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        print("Update Button Clicked")
 
        userName = utName.text ?? ""
        userEmail = utEmail.text ?? ""
        userPassword = utPassword.text ?? ""
        userMobileNumber = utMobileNumber.text ?? ""
        userCarPlateNumber = utCarPlateNumber.text ?? ""
        
        
        if (userName.isEmpty || userEmail.isEmpty || userPassword.isEmpty || userMobileNumber.isEmpty || userCarPlateNumber.isEmpty) {
                    let errorEmpty = "You must enter all required fields. "
                    createAlert(errorName: errorEmpty)
                }
        else if ((userEmail.isValidEmail) == false){
            let errorEmail = "Email ID is invalid"
            createAlert(errorName: errorEmail)
        }
        
        else if userCarPlateNumber.count != 5 {
            let errorCarPlate = "Please enter valid 5 digit Car Plate Number"
            createAlert(errorName: errorCarPlate)
        }
        
        else {
        
        print("Updating the values in user class...")
        
        
        
        User.getInstance().name = userName
        User.getInstance().email = userEmail
        User.getInstance().password = userPassword
        User.getInstance().phone = userMobileNumber
        User.getInstance().carPlateNumber = userCarPlateNumber
        
        
        
        var newUserInfo = [
        
            "name" : userName,
            "email" : userEmail,
            "password" : userPassword,
            "phone" : userMobileNumber,
            "car_plate_number" : userCarPlateNumber
        
        ]
        
        db.collection("users").document(User.getInstance().id!).setData(newUserInfo)
        print("Storing values to FireStore database...")
        print("***********************")
        print("new values are : ")
        print("\(userName), \(userEmail),\(userPassword),\(userMobileNumber),\(userCarPlateNumber)")
        print("Data Saved To FireStore Database")
        
    }
}
    
    func createAlert(errorName:String) {
        let alert = UIAlertController(title: "Error", message: errorName, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: " OK ", style: .cancel, handler: {
                                        action in print("tapped OK")}) )
        present(alert,animated: true)
        
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        
        print("Logout Button Clicked")
        
        print("Logging Out ...")
        
        UserDefaults.standard.set("", forKey:"email")
        UserDefaults.standard.set("", forKey:"pass")

        User.getInstance().name = ""
        User.getInstance().email = ""
        User.getInstance().password = ""
        User.getInstance().phone = ""
        User.getInstance().carPlateNumber = ""
        
        self.resetDefaults()
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
            
            self.db.collection("users").document(User.getInstance().id!).delete{ (error) in
                if error != nil {
                    print("There was an error while deleting the user info")
                }
                else{
                    print("user Deleted")
                    print("Deleting user email and password from defaults ...")
                    self.resetDefaults()
                    print("User defaults deleted.")
                    print("Deleting User info from server...")
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
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
    









