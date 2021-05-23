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

struct Address {
    var street:String
    var city:String
    var province:String
    var country:String
    
    init() {
        self.street = ""
        self.city = ""
        self.province = ""
        self.country = ""
    }
    
    func getCompleteAddress() -> String {
        
        return "\(self.street), \(self.city), \(self.province), \(self.country)"
    }
    
    func getShortAddress() -> String {
        return "\(self.street), \(self.city), \(self.country)"
    }
}

class LocationController {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var address:Address
    var lat:Double
    var long:Double
    
    init() {
        self.address = Address()
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
    
    // MARK: - GeoLocation
    
    func fetchLocationCoord(address : String, completionHandler: @escaping ()->Void){
        self.geocoder.geocodeAddressString(address, completionHandler: { (placemark, error) in
            self.processCoordGeoResponse(placemarks: placemark, error: error){
                () in
                completionHandler()
            }
        })
    }
    
    private func processCoordGeoResponse(placemarks: [CLPlacemark]?, error: Error?, completionHandler: @escaping ()->Void) {
        
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
                completionHandler()
            } else {
                print("No coordinates Found")
            }
        }
    }
    
    // MARK: - Reverse GeoLocation
    
    func fetchAddress(location : CLLocation, completionHandler: @escaping ()->Void) {
        self.geocoder.reverseGeocodeLocation(location, completionHandler: { (placemark, error) in
            self.processReverseGeoResponse(placemarkList: placemark, error: error){() in
                completionHandler()
            }
        })
    }
    
    private func processReverseGeoResponse(placemarkList : [CLPlacemark]?, error : Error?, completionHandler: @escaping ()->Void) {

        if error != nil {
            print("Unable to get address")
        } else {
            if let placemarks = placemarkList, let placemark = placemarks.first {
                
                let street = placemark.thoroughfare ?? "Unknown"
                let city = placemark.locality ?? "Unknown"
                let province = placemark.administrativeArea ?? "Unknown"
                let country = placemark.country ?? "Unknown"
                
                self.address.street = "\(street)"
                self.address.city = "\(city)"
                self.address.province = "\(province)"
                self.address.country = "\(country)"
                print(self.address.getCompleteAddress())
                completionHandler()
                
            } else {
                print("No Address Found")
            }
        }
    }
    
    // MARK: - Route
    
    func fetchRoute(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D, completionHandler: @escaping (MKDirections.Response)->Void) {
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            guard let unwrappedResponse = response else { return }
            
            completionHandler(unwrappedResponse)
        }
    }
}
