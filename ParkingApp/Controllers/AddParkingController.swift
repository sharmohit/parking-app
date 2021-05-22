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
    
    func AddParking(buildingCode:String, parkingHours:Double, carPlateNumber:String, suitNumber:Int) {
        var newParking = Parking()
        newParking.buildingCode = buildingCode
        newParking.parkingHours = parkingHours
        newParking.carPlateNumber = carPlateNumber
        newParking.suitNumber = suitNumber
        self.parking.AddParkingData(parking: newParking)
    }
}
