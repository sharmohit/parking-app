//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  AddParkingViewController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 14/05/21.
//

import UIKit

class AddParkingViewController: UIViewController {
    
    private let user = User.getInstance()
    private var addParkingController = AddParkingController()
    
    @IBOutlet weak var buildingCodeTextField: UITextField!
    @IBOutlet weak var hoursSegment: UISegmentedControl!
    @IBOutlet weak var plateNumberTextField: UITextField!
    @IBOutlet weak var suitNumberTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plateNumberTextField.text = self.user.carPlateNumber
    }
    
    @IBAction func locateMeWasTapped(_ sender: UIButton) {
        print("Locate me was tapped")
    }
    
    @IBAction func addParkingWasTapped(_ sender: UIButton) {
        
        let errorMsg = self.addParkingController.addParking(
            userID: self.user.email,
            buildingCode: buildingCodeTextField.text!,
            parkingHours: getHourFromSegmentIndex(segmentIndex: hoursSegment.selectedSegmentIndex),
            carPlateNumber: plateNumberTextField.text!,
            suitNumber: Int(suitNumberTextField.text!) ?? 0)
        
        if !errorMsg.isEmpty {
            showAlert(title: "Error", message: errorMsg)
        }
        self.clearInputs()
    }
    
    private func clearInputs() {
        buildingCodeTextField.text = ""
        plateNumberTextField.text = ""
        suitNumberTextField.text = ""
        locationTextField.text = ""
    }
    
    private func getHourFromSegmentIndex(segmentIndex:Int) -> Double {
        switch segmentIndex {
        case 0:
            return 1.0
        case 1:
            return 4.0
        case 2:
            return 12.0
        case 3:
            return 24.0
        default:
            return -0.0
        }
    }
    
    private func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message:
                                                    message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
