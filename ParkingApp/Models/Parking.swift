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
    var delegate:FirestoreFetchDelegate?
    
    @DocumentID var id:String?
    var buildingCode:String
    var parkingHours:Double
    var carPlateNumber:String
    var suitNumber:Int
    var locLat:Double
    var locLong:Double
    var dateTime:Timestamp
    
    enum CodingKeys : String, CodingKey {
        case buildingCode = "building_code"
        case parkingHours = "parking_hours"
        case carPlateNumber = "car_plate_number"
        case suitNumber = "suit_number"
        case locLat = "loc_lat"
        case locLong = "loc_long"
        case dateTime = "date_time"
    }
    
    init() {
        self.delegate = nil
        self.id = ""
        self.buildingCode = ""
        self.parkingHours = 0.0
        self.carPlateNumber = ""
        self.suitNumber = 0
        self.locLat = 0.0
        self.locLong = 0.0
        self.dateTime = Timestamp()
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
        self.buildingCode = try values.decode(String.self, forKey: .buildingCode)
        self.parkingHours = try values.decode(Double.self, forKey: .parkingHours)
        self.carPlateNumber = try values.decode(String.self, forKey: .carPlateNumber)
        self.suitNumber = try values.decode(Int.self, forKey: .suitNumber)
        self.locLat = try values.decode(Double.self, forKey: .locLat)
        self.locLong = try values.decode(Double.self, forKey: .locLat)
        self.dateTime = try values.decode(Timestamp.self, forKey: .dateTime)
    }
    
    func AddParkingData(parking:Parking) {
        do {
            try db.collection("parkings").addDocument(from : parking)
        } catch {
            print(error)
        }
    }
}
