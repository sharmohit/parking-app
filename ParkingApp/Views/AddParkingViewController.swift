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
    
    //private var currentLocation:CLLocationCoordinate2D?
    
    @IBOutlet weak var buildingCodeTextField: UITextField!
    @IBOutlet weak var hoursSegment: UISegmentedControl!
    @IBOutlet weak var plateNumberTextField: UITextField!
    @IBOutlet weak var suitNumberTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var locationActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locateMeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationController.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.clearInputs()
        self.locationActivityIndicator.isHidden = true
    }
    
    @IBAction func locateMeWasTapped(_ sender: UIButton) {
        
        self.locationController.requestLocationAccess(requireContinuousUpdate: false)
        self.locationActivityIndicator.isHidden = false
        self.locateMeButton.isEnabled = false
        self.locationTextField.isEnabled = false
        self.locationActivityIndicator.startAnimating()
    }
    
    @IBAction func addParkingWasTapped(_ sender: UIButton) {
        
        let errorMsg = validateParking()
        
        if errorMsg.isEmpty {
            self.locationController.fetchLocationCoord(address: self.locationTextField.text!){
                (errorMsg) in
                if let error = errorMsg {
                    self.showAlert(title: "Error", message: error)
                }else {
                    self.addParking(lat: self.locationController.lat,
                                    long: self.locationController.long)
                }
            }
        } else {
            showAlert(title: "Error", message: errorMsg)
        }
    }
    
    private func validateParking() -> String {
        
        if self.buildingCodeTextField.text!.isEmpty {
            return "Building code is empty"
        } else if self.buildingCodeTextField.text!.count != 5 {
            return "Building Code must have 5 alphanumeric characters"
        } else if hoursSegment.selectedSegmentIndex < 0 {
            return "Please select parking hours"
        } else if self.plateNumberTextField.text!.isEmpty {
            return "Car plate number is empty"
        } else if self.plateNumberTextField.text!.count > 8 {
            return "Maximum 8 alphanumeric characters allowed for Car Plate Number"
        } else if self.plateNumberTextField.text!.count < 2 {
            return "Minimum 2 alphanumeric characters required for Car Plate Number"
        } else if self.suitNumberTextField.text!.isEmpty {
            return "Suit number is empty"
        } else if self.suitNumberTextField.text!.count > 5 {
            return "Maximum 8 alphanumeric characters allowed for Suit Number"
        } else if self.suitNumberTextField.text!.count < 2 {
            return "Minimum 2 alphanumeric characters required for Suit Number"
        } else if self.locationTextField.text!.isEmpty {
            return "Please provide parking location"
        } else {
            return ""
        }
    }
    
    private func addParking(lat:Double, long:Double) {
        
        self.addParkingController.addParking(
            userID: self.user.id!,
            buildingCode: self.buildingCodeTextField.text!,
            parkingHours: self.getHourFromSegmentIndex(segmentIndex: self.hoursSegment.selectedSegmentIndex),
            carPlateNumber: self.plateNumberTextField.text!,
            suitNumber: Int(self.suitNumberTextField.text!) ?? 0,
            address: self.locationTextField.text!,
            lat: lat, long: long){
            (error) in
            
            if let error = error {
                self.showAlert(title: "Error", message: error)
            } else {
                self.self.showAlert(title: "Success", message: "Parking added succesfully")
                self.clearInputs()
            }
        }
    }
    
    private func clearInputs() {
        buildingCodeTextField.text = ""
        hoursSegment.selectedSegmentIndex = -1
        plateNumberTextField.text = user.carPlateNumber
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

extension AddParkingViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = manager.location?.coordinate {
            locationController.fetchAddress(
                location:CLLocation(latitude: location.latitude,
                                    longitude: location.longitude)){
                (errorMsg) in
                self.locationActivityIndicator.stopAnimating()
                self.locationActivityIndicator.isHidden = true
                self.locateMeButton.isEnabled = true
                self.locationTextField.isEnabled = true
                
                if let error = errorMsg {
                    self.showAlert(title: "Error", message: error)
                }else {
                    self.locationTextField.text = self.locationController.address.getCompleteAddress()
                }
            }
        } else {
            if manager.authorizationStatus == .authorizedWhenInUse ||
                    manager.authorizationStatus == .authorizedAlways {
                showAlert(title: "Error", message: "Unable to get location, Try again")
            } else {
                self.locationController.requestLocationAccess(requireContinuousUpdate: false)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //print(#function, "Unable to get location \(error) Permission \(manager.authorizationStatus.rawValue)")
        
        if manager.authorizationStatus == .denied {
            self.showLocationServicesAlert()
        } else if manager.authorizationStatus == .authorizedWhenInUse ||
                    manager.authorizationStatus == .authorizedAlways {
            self.locationController.requestLocationAccess(requireContinuousUpdate: false)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .denied {
            self.showLocationServicesAlert()
        }
    }
    
    func showLocationServicesAlert() {
        showAlert(title: "Attention", message: "Parking App need location access for locating your address. Please enable by visiting Settings > Privacy > Location Services > ParkingApp")
    }
}
