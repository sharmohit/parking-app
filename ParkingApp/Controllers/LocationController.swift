//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  LocationController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 23/05/21.
//

import Foundation
import CoreLocation

class LocationController {
    
    private let geocoder = CLGeocoder()
    
    // MARK: - Forward GeoLocation
    
    //let postalAddress = "\(country), \(city), \(street)"
    //self.getLocation(address: postalAddress)
    
    private func getLocationCoord(address : String){
        self.geocoder.geocodeAddressString(address, completionHandler: { (placemark, error) in
            self.processCoordGeoResponse(placemarks: placemark, error: error)
        })
    }
    
    private func processCoordGeoResponse(placemarks: [CLPlacemark]?, error: Error?) {
        
        if error != nil {
            print("Unable to get location coordinates")
        } else {
            var obtainedLocation : CLLocation?
            
            if let placemark = placemarks, placemarks!.count > 0 {
                obtainedLocation = placemark.first?.location
            }
            
            if obtainedLocation != nil {
                print("lat \(obtainedLocation!.coordinate.latitude) , lng \(obtainedLocation!.coordinate.longitude)")
            } else {
                print("No coordinates Found")
            }
        }
    }
    
    // MARK: - Reverse GeoLocation
    
    //self.getAddress(location : CLLocation(latitude: lat, longitude: lng))
    
    func getAddress(location : CLLocation){
        self.geocoder.reverseGeocodeLocation(location, completionHandler: { (placemark, error) in
            self.processReverseGeoResponse(placemarkList: placemark, error: error)
        })
    }
    
    func processReverseGeoResponse(placemarkList : [CLPlacemark]?, error : Error?) {
        if error != nil {
            print("Unable to get address")
        } else {
            if let placemarks = placemarkList, let placemark = placemarks.first {
                
                let street = placemark.thoroughfare ?? "N/A"
                let city = placemark.locality ?? "N/A"
                let province = placemark.administrativeArea ?? "N/A"
                let country = placemark.country ?? "N/A"
                
                print("\(street), \(city), \(province), \(country)")
                
            } else {
                print("No Address Found")
            }
        }
    }
}
