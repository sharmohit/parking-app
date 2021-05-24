//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  User.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 19/05/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class User : Codable {
    
    private static var shared:User?
    static func getInstance() -> User {
        if self.shared != nil {
            return self.shared!
        } else {
            self.shared = User()
            return self.shared!
        }
    }
    
    private let db = Firestore.firestore()
    
    @DocumentID var id:String?
    var email:String
    var name:String
    var password:String
    var phone:String
    var carPlateNumber:String
    
    init() {
        self.id = ""
        self.email = ""
        self.name = ""
        self.password = ""
        self.phone = ""
        self.carPlateNumber = ""
    }
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case email = "email"
        case name = "name"
        case password = "password"
        case phone = "phone"
        case carPlateNumber = "car_plate_number"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.password, forKey: .password)
        try container.encode(self.phone, forKey: .phone)
        try container.encode(self.carPlateNumber, forKey: .carPlateNumber)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try values.decode(DocumentID<String>.self, forKey: .id)
        self.email = try values.decode(String.self, forKey: .email)
        self.name = try values.decode(String.self, forKey: .name)
        self.password = try values.decode(String.self, forKey: .password)
        self.phone = try values.decode(String.self, forKey: .phone)
        self.carPlateNumber = try values.decode(String.self, forKey: .carPlateNumber)
    }
    
    func fetchUser(id:String, completion: @escaping (String?) -> Void) {
        
        db.collection("users").whereField("email", isEqualTo: id).getDocuments{ (queryResults, error) in
            
            if error != nil {
                completion("An internal error occured")
            } else if queryResults!.documents.count == 0 {
                completion("User doesn't exist")
            } else {
                do {
                    if let user = try queryResults!.documents.first?.data(as : User.self) {
                        self._id = user._id
                        self.email = user.email
                        self.name = user.name
                        self.password = user.password
                        self.phone = user.phone
                        self.carPlateNumber = user.carPlateNumber
                        completion(nil)
                    } else {
                        completion("User doesn't exist")
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
