
//  Group: Project Groups 12
//  Name: Javtesh Singh
//  Student ID: 101348129
//  Group Member: Mohit Sharma
//  Member ID: 101342267

//
//  TheUser.swift
//  ParkingApp
//
//  Created by Javtesh Singh on 22/05/21.
//

import Foundation

class TheUser{
    
    static let userObject = TheUser()
    
    private init(){
    }
    var id = ""
    var name = ""
    var email = ""
    var pass = ""
    var mobileNo = ""
    var carPlateNo = ""
    
}

// use this to access properties anywhere:  TheUser.userObject.name
