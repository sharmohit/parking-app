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

public protocol FirestoreFetchDelegate {
    func fetchCompleted(isError:Bool)
}

class User {
    
    private let db = Firestore.firestore()
    var delegate:FirestoreFetchDelegate?
    
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
                    self.delegate?.fetchCompleted(isError: false)
                }
            })
            
        } catch {
            print(error)
        }
    }
}
