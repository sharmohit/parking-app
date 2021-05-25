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
import MapKit
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Parking : Codable {
    
    private let db = Firestore.firestore()
    
    @DocumentID var id:String?
    var buildingCode:String
    var parkingHours:Double
    var carPlateNumber:String
    var suitNumber:String
    var streetAddress:String
    var coordinate:CLLocationCoordinate2D
    var dateTime:Timestamp
    
    init() {
        self.buildingCode = ""
        self.parkingHours = 0.0
        self.carPlateNumber = ""
        self.suitNumber = ""
        self.streetAddress = ""
        self.coordinate = CLLocationCoordinate2D()
        self.dateTime = Timestamp()
    }
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case buildingCode = "building_code"
        case parkingHours = "parking_hours"
        case carPlateNumber = "car_plate_number"
        case suitNumber = "suit_number"
        case streetAddress = "street_address"
        case coordinate = "coordinate"
        case dateTime = "date_time"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.buildingCode, forKey: .buildingCode)
        try container.encode(self.parkingHours, forKey: .parkingHours)
        try container.encode(self.carPlateNumber, forKey: .carPlateNumber)
        try container.encode(self.suitNumber, forKey: .suitNumber)
        try container.encode(self.streetAddress, forKey: .streetAddress)
        try container.encode(GeoPoint.init(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude), forKey: .coordinate)
        try container.encode(self.dateTime, forKey: .dateTime)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try values.decode(DocumentID<String>.self, forKey: .id)
        self.buildingCode = try values.decode(String.self, forKey: .buildingCode)
        self.parkingHours = try values.decode(Double.self, forKey: .parkingHours)
        self.carPlateNumber = try values.decode(String.self, forKey: .carPlateNumber)
        self.suitNumber = try values.decode(String.self, forKey: .suitNumber)
        self.streetAddress = try values.decode(String.self, forKey: .streetAddress)
        let geoPoint = try values.decode(GeoPoint.self, forKey: .coordinate)
        self.coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
        self.dateTime = try values.decode(Timestamp.self, forKey: .dateTime)
    }
    
    func addParking(userID:String, parking:Parking, completion: @escaping (String?) -> Void ){
        do {
            try self.db.collection("users/\(userID)/parkings").addDocument(from : parking){
                (error) in
                if let error = error {
                    completion("Unable to add parking. Please Try again. Error: \(error)")
                } else {
                    completion(nil)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getParkingByDocumentID(_ documentID:String, completion: @escaping (Parking) -> Void) {
        self.db.collection("parkings").document(documentID).getDocument{
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
        self.db.collection("users/\(userID)/parkings").order(by: "date_time", descending: true).getDocuments(){
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
}
