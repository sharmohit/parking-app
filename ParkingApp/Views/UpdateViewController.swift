
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

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var utName: UITextField!
    
    @IBOutlet weak var utEmail: UITextField!
    
    @IBOutlet weak var utPassword: UITextField!
    
    @IBOutlet weak var utMobileNumber: UITextField!
    
    @IBOutlet weak var utCarPlateNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Update screen loaded ...")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        print("save Button Clicked")
        
        let userName = utName.text ?? ""
        let userEmail = utEmail.text ?? ""
        let userPassword = utPassword.text ?? ""
        let userMobileNumber = utPassword.text ?? ""
        let userCarPlateNumber = utCarPlateNumber.text ?? ""
        
        print("Data Saved")
        
    }
    

}
