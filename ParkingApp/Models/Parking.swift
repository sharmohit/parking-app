//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  Parking.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 22/05/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Parking : Codable {
    
    private let db = Firestore.firestore()
    
    @DocumentID var id:String?
    var buildingCode:String
    var parkingHours:Double
    var carPlateNumber:String
    var suitNumber:Int
    var locLat:Double
    var locLong:Double
    var dateTime:Timestamp
    
    init() {
        self.buildingCode = ""
        self.parkingHours = 0.0
        self.carPlateNumber = ""
        self.suitNumber = 0
        self.locLat = 0.0
        self.locLong = 0.0
        self.dateTime = Timestamp()
    }
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case buildingCode = "building_code"
        case parkingHours = "parking_hours"
        case carPlateNumber = "car_plate_number"
        case suitNumber = "suit_number"
        case locLat = "loc_lat"
        case locLong = "loc_long"
        case dateTime = "date_time"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.buildingCode, forKey: .buildingCode)
        try container.encode(self.parkingHours, forKey: .parkingHours)
        try container.encode(self.carPlateNumber, forKey: .carPlateNumber)
        try container.encode(self.suitNumber, forKey: .suitNumber)
        try container.encode(self.locLat, forKey: .locLat)
        try container.encode(self.locLong, forKey: .locLong)
        try container.encode(self.dateTime, forKey: .dateTime)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try values.decode(DocumentID<String>.self, forKey: .id)
        self.buildingCode = try values.decode(String.self, forKey: .buildingCode)
        self.parkingHours = try values.decode(Double.self, forKey: .parkingHours)
        self.carPlateNumber = try values.decode(String.self, forKey: .carPlateNumber)
        self.suitNumber = try values.decode(Int.self, forKey: .suitNumber)
        self.locLat = try values.decode(Double.self, forKey: .locLat)
        self.locLong = try values.decode(Double.self, forKey: .locLong)
        self.dateTime = try values.decode(Timestamp.self, forKey: .dateTime)
    }
    
    func addParking(userID:String, parking:Parking, completion: @escaping (String?) -> Void ){
        do {
            try db.collection("users/\(userID)/parkings").addDocument(from : parking){
                (error) in
                if let error = error {
                    completion("Unable to add parking. Please Try again")
                } else {
                    completion(nil)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getParkingByDocumentID(_ documentID:String, completion: @escaping (Parking) -> Void) {
        db.collection("parkings").document(documentID).getDocument{
            (queryResult, error) in
            
            if let error = error {
                print("Error occured when fetching parking from firestore. Error: \(error)")
                return
            } else {
                do {
                    if let parking = try queryResult?.data(as : Parking.self) {
                        completion(parking)
                    } else {
                        print("No parking found")
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func getUserParkings(userID:String, completion: @escaping ([Parking]?, String?) -> Void) {
        db.collection("users/\(userID)/parkings").order(by: "date_time", descending: true).getDocuments(){
            (queryResults, error) in
            
            if error != nil {
                completion(nil,"An internal error occured")
            } else if queryResults!.documents.count == 0 {
                completion(nil, "No parkings added")
            } else {
                do {
                    var parkingList:[Parking] = [Parking]()
                    for result in queryResults!.documents {
                        if let parking = try result.data(as : Parking.self) {
                            parkingList.append(parking)
                        }
                    }
                    completion(parkingList, nil)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    /*
     func mapUserParking(userID:String, parkingID:String) {
     do {
     try db.collection("users_parkings").addDocument(
     data: ["email": userID, "parking_id": parkingID])
     } catch {
     print(error)
     }
     }*/
}
