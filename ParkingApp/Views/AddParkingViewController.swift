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
    
    private var addParkingController = AddParkingController()
    
    @IBOutlet weak var buildingCodeTextField: UITextField!
    @IBOutlet weak var hoursSegment: UISegmentedControl!
    @IBOutlet weak var plateNumberTextField: UITextField!
    @IBOutlet weak var suitNumberTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("AddParkingViewController")
    }
    
    @IBAction func locateMeWasTapped(_ sender: UIButton) {
        print("Locate me was tapped")
    }
    
    @IBAction func addParkingWasTapped(_ sender: UIButton) {
        print("Add parking was tapped")
        addParkingController.AddParking(buildingCode: buildingCodeTextField.text!, parkingHours:4, carPlateNumber: plateNumberTextField.text!, suitNumber: Int(suitNumberTextField.text!) ?? 0)
        self.clearInputs()
    }
    
    func clearInputs() {
        buildingCodeTextField.text = ""
        plateNumberTextField.text = ""
        suitNumberTextField.text = ""
        locationTextField.text = ""
    }
}
