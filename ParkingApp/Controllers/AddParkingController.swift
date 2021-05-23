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
    
    /// Return error string if add parking fail.
    func addParking(userID:String, buildingCode:String, parkingHours:Double, carPlateNumber:String, suitNumber:Int, lat:Double, long:Double) -> String {
        
        self.parking.buildingCode = buildingCode
        self.parking.parkingHours = parkingHours
        self.parking.carPlateNumber = carPlateNumber
        self.parking.suitNumber = suitNumber
        self.parking.locLat = lat
        self.parking.locLong = long
        if let documentRef = self.parking.AddParkingData(parking: self.parking) {
            self.parking.mapUserParking(userID: userID ,parkingID: documentRef.documentID)
        }
        
        return self.validateParking()
    }
    
    /// Return error string if validation fail.
    private func validateParking() -> String {
        
        if self.parking.buildingCode.isEmpty {
            return "Building code is empty"
        }
        if self.parking.buildingCode == "0" {
            return "Invalid building code"
        }
        if self.parking.suitNumber == 0 {
            return "Invalid suit number"
        }
        
        return ""
    }
}
