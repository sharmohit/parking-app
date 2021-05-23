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
import MapKit

class AddParkingViewController: UIViewController {
    
    private let user = User.getInstance()
    private var locationController = LocationController()
    private var addParkingController = AddParkingController()
    
    private var currentLocation:CLLocationCoordinate2D?
    
    @IBOutlet weak var buildingCodeTextField: UITextField!
    @IBOutlet weak var hoursSegment: UISegmentedControl!
    @IBOutlet weak var plateNumberTextField: UITextField!
    @IBOutlet weak var suitNumberTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationController.initialize(delegate: self)
        self.plateNumberTextField.text = self.user.carPlateNumber
    }
    
    @IBAction func locateMeWasTapped(_ sender: UIButton) {
        print(currentLocation!)
        locationController.fetchAddress(
            location:CLLocation(latitude: self.currentLocation?.latitude ?? 0.0,
                                longitude: self.currentLocation?.longitude ?? 0.0)){
            () in
            self.locationTextField.text = self.locationController.address.getCompleteAddress()
        }
    }
    
    @IBAction func addParkingWasTapped(_ sender: UIButton) {
        
        let address = self.locationTextField.text!
        if address.isEmpty {
            showAlert(title: "Error", message: "Parking location is empty")
        } else {
            self.locationController.fetchLocationCoord(address: address){
                () in
                self.addParking(lat: self.locationController.lat,
                           long: self.locationController.long)
            }
        }
    }
    
    private func addParking(lat:Double, long:Double) {
        let errorMsg = self.addParkingController.addParking(
            userID: self.user.id!,
            buildingCode: buildingCodeTextField.text!,
            parkingHours: getHourFromSegmentIndex(segmentIndex: hoursSegment.selectedSegmentIndex),
            carPlateNumber: plateNumberTextField.text!,
            suitNumber: Int(suitNumberTextField.text!) ?? 0,
            lat: lat, long: long)
        
        if !errorMsg.isEmpty {
            showAlert(title: "Error", message: errorMsg)
        }
        self.clearInputs()
    }
    
    private func clearInputs() {
        buildingCodeTextField.text = ""
        suitNumberTextField.text = user.carPlateNumber
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

extension AddParkingViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.currentLocation = manager.location?.coordinate
        
        if self.currentLocation == nil {
            self.showAlert(title: "Error", message: "Unable to get location.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "Unable to get location \(error)")
    }
}
