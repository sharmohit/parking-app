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

public protocol FirestoreFetchDelegate {
    func fetchCompleted(isError:Bool)
}

class User {
    
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
    var delegate:FirestoreFetchDelegate?
    
    var id:String
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
    
    func fetchUserData(id:String) {
        
        do {
            try db.collection("users").whereField("email", isEqualTo: id).getDocuments(completion: { (queryResults, error) in
                
                if let err = error {
                    print("Error occured in Firestore \(err)")
                    self.delegate?.fetchCompleted(isError: true)
                } else if queryResults!.documents.count == 0 {
                    print("No records found in Users")
                    self.delegate?.fetchCompleted(isError: false)
                } else {
                    let result = queryResults!.documents.first?.data()
                    self.email = result?["email"] as! String
                    self.name = result?["name"] as! String
                    self.password = result?["password"] as! String
                    self.phone = result?["phone"] as! String
                    self.carPlateNumber = result?["car_plate_number"] as! String
                    self.delegate?.fetchCompleted(isError: false)
                }
            })
            
        } catch {
            print(error)
        }
    }
}
