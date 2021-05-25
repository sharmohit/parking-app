//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  AddParkingController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 22/05/21.
//

import Foundation
import FirebaseFirestore

class AddParkingController {
    
    private var parking:Parking
    
    init() {
        self.parking = Parking()
    }
    
    func addParking(userID:String, buildingCode:String, parkingHours:Double, carPlateNumber:String, suitNumber:String, address:String, lat:Double, long:Double, completion:@escaping (String?) -> Void) {
        
        self.parking.buildingCode = buildingCode
        self.parking.parkingHours = parkingHours
        self.parking.carPlateNumber = carPlateNumber
        self.parking.suitNumber = suitNumber
        self.parking.streetAddress = address
        self.parking.coordinate.latitude = lat
        self.parking.coordinate.longitude = long
        self.parking.dateTime = Timestamp()
        self.parking.addParking(userID: User.getInstance().id!, parking: self.parking){
            (error) in
            completion(error)
        }
    }
}
