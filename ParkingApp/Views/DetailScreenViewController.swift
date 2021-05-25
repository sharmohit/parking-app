
//  Group: Project Groups 12
//  Name: Javtesh Singh
//  Student ID: 101348129
//  Group Member: Mohit Sharma
//  Member ID: 101342267


//  DetailScreenViewController.swift
//  ParkingApp
//
//  Created by Javtesh Singh on 18/05/21.
//

import UIKit

class DetailScreenViewController: UIViewController {
    
    private let formatter = DateFormatter()
    
    

    
    @IBOutlet weak var lblBulidingCode: UILabel!
    
    
    @IBOutlet weak var lblNumberOfHours: UILabel!
    
    @IBOutlet weak var lblSuitNumber: UILabel!
    
    @IBOutlet weak var lblLocationOfCar: UILabel!
    
    @IBOutlet weak var lblDateAndTime: UILabel!
    
    var parking:Parking?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Parking Detail Screeen Loaded.")
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium

        let datetime = formatter.string(from: parking!.dateTime.dateValue())
        print(datetime)
        
        
//        var newLoc:LocationController
//        newLoc.lat = parking!.locLat
//        newLoc.long = parking!.locLong
        
        lblBulidingCode.text = parking?.buildingCode
        lblNumberOfHours.text = parking?.parkingHours.description
        lblSuitNumber.text = parking?.suitNumber.description
        //lblLocationOfCar.text =
        lblDateAndTime.text = formatter.string(from: parking!.dateTime.dateValue())
        
        print("Location of user is : ")
        
        var lat = parking!.locLat
        var long = parking!.locLong
        
        print("\tLatitiude is \(lat)")
        print("\tLongitude is \(long)")
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getDirection(_ sender: Any) {
        
        print(#function,"getDirection pressed")
        
    }
    
}
