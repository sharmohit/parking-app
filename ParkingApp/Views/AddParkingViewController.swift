//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//
//  AddParkingViewController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 14/05/21.
//

import UIKit

class AddParkingViewController: UIViewController {
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
    }
}
