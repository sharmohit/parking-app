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
import MapKit

protocol LocationFetchDelegate {
    func addressFetched()
    func locationFetched()
}

class LocationController {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var delegate:LocationFetchDelegate?
    var address:String
    var lat:Double
    var long:Double
    
    init() {
        self.address = ""
        self.lat = 0.0
        self.long = 0.0
    }
    
    func initialize(delegate:CLLocationManagerDelegate?) {
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("Location access granted")
            
            self.locationManager.delegate = delegate
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            self.locationManager.startUpdatingLocation()
            
        } else {
            print("Location access denied")
        }
    }
    
    // MARK: - Forward GeoLocation
    
    //let postalAddress = "\(country), \(city), \(street)"
    //self.getLocation(address: postalAddress)
    
    func fetchLocationCoord(address : String){
        self.geocoder.geocodeAddressString(address, completionHandler: { (placemark, error) in
            self.processCoordGeoResponse(placemarks: placemark, error: error)
        })
    }
    
    private func processCoordGeoResponse(placemarks: [CLPlacemark]?, error: Error?) {
        
        self.lat = 0.0
        self.long = 0.0
        
        if error != nil {
            print("Unable to get location coordinates")
        } else {
            var obtainedLocation : CLLocation?
            
            if let placemark = placemarks, placemarks!.count > 0 {
                obtainedLocation = placemark.first?.location
            }
            
            if obtainedLocation != nil {
                print("lat \(obtainedLocation!.coordinate.latitude) , lng \(obtainedLocation!.coordinate.longitude)")
                self.lat = obtainedLocation!.coordinate.latitude
                self.long = obtainedLocation!.coordinate.longitude
            } else {
                print("No coordinates Found")
            }
        }
        self.delegate?.locationFetched()
    }
    
    // MARK: - Reverse GeoLocation
    
    //self.getAddress(location : CLLocation(latitude: lat, longitude: lng))
    
    func fetchAddress(location : CLLocation) {
        self.geocoder.reverseGeocodeLocation(location, completionHandler: { (placemark, error) in
            self.processReverseGeoResponse(placemarkList: placemark, error: error)
        })
    }
    
    func processReverseGeoResponse(placemarkList : [CLPlacemark]?, error : Error?) {
        
        self.address = ""
        
        if error != nil {
            print("Unable to get address")
        } else {
            if let placemarks = placemarkList, let placemark = placemarks.first {
                
                let street = placemark.thoroughfare ?? "N/A"
                let city = placemark.locality ?? "N/A"
                let province = placemark.administrativeArea ?? "N/A"
                let country = placemark.country ?? "N/A"
                
                self.address = "\(street), \(city), \(province), \(country)"
                
            } else {
                print("No Address Found")
            }
        }
        self.delegate?.addressFetched()
    }
}
