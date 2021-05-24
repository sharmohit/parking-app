//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  ViewParkingController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 23/05/21.
//

import Foundation

class ViewParkingController {
    
    private var parking:Parking
    
    init() {
        self.parking = Parking()
    }
    
    func fetchParking(documentID:String, completion: @escaping (Parking) -> Void) {
        
        self.parking.getParkingByDocumentID(documentID){
            (parking) in
            completion(parking)
        }
    }
    
    func fetchUserParkings(userID:String, completion: @escaping ([Parking]?, String?) -> Void) {
        self.parking.getUserParkings(userID: userID){
            (parkingList, error) in
            print("Parking Count: \(parkingList!.count)")
            completion(parkingList, error)
        }
    }
}
