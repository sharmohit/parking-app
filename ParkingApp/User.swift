////  Group: Project Groups 12
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

class User {
    
    private let db = Firestore.firestore()
    
    var email:String
    var name:String
    var password:String
    var phone:String
    
    init() {
        self.email = ""
        self.name = ""
        self.password = ""
        self.phone = ""
    }
    
    func fetchUserData(id:String) -> User? {
        
        do {
            try db.collection("users").getDocuments(completion: { (queryResults, error) in
                
                if let err = error {
                    print("Error occured in Firestore \(err)")
                } else if queryResults!.documents.count == 0 {
                    print("No records found in Users")
                } else {
                    for result in queryResults!.documents {
                        print(result.data())
                    }
                }
            })
            
        } catch {
            print(error)
        }
        
        return nil
    }
}
