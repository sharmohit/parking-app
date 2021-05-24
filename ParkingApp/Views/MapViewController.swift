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
//
//  MapViewController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 23/05/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var locationController = LocationController()
    
    var parkingCoordinate = CLLocationCoordinate2D(latitude: 18.5204, longitude: 73.8567)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationController.requestLocationAccess(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mapView.removeAnnotations(mapView.annotations)
    }
    
    private func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message:
                                                    message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension MapViewController : CLLocationManagerDelegate, MKMapViewDelegate{
        
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.black
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func locationDidCalculateRoute(response: MKDirections.Response) {
        
        if let route = response.routes.first {
            
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            
            let srcAnnotation = MKPointAnnotation()
            srcAnnotation.coordinate = response.source.placemark.coordinate
            srcAnnotation.title = "You are here"
            
            let destAnnotation = MKPointAnnotation()
            destAnnotation.coordinate = response.destination.placemark.coordinate
            destAnnotation.title = "Parking is here"
            
            self.mapView.addAnnotation(srcAnnotation)
            self.mapView.addAnnotation(destAnnotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.locationController.fetchRoute(pickupCoordinate: manager.location!.coordinate, destinationCoordinate: self.parkingCoordinate){
            (response) in
            
            if let response = response {
                
                if let route = response.routes.first {
                    
                    self.mapView.addOverlay(route.polyline)
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
                    
                    let srcAnnotation = MKPointAnnotation()
                    srcAnnotation.coordinate = response.source.placemark.coordinate
                    srcAnnotation.title = "You are here"
                    
                    let destAnnotation = MKPointAnnotation()
                    destAnnotation.coordinate = response.destination.placemark.coordinate
                    destAnnotation.title = "Parking is here"
                    
                    self.mapView.addAnnotation(srcAnnotation)
                    self.mapView.addAnnotation(destAnnotation)
                }
            } else {
                self.showAlert(title: "Error", message: "Unable to process route")
            }
        }
    }
}
