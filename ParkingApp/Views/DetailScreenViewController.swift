
//  Group: Project Groups 12
//  Name: Javtesh Singh
//  Student ID: 101348129
//  Group Member: Mohit Sharma
//  Member ID: 101342267


//  DetailScreenViewController.swift
//  ParkingApp
//
//  Created by Javtesh Singh on 18/05/21.
//

import UIKit

class DetailScreenViewController: UIViewController {
    
    private let formatter = DateFormatter()
    
    
    @IBOutlet weak var lblBulidingCode: UILabel!
    
    
    @IBOutlet weak var lblNumberOfHours: UILabel!
    
    @IBOutlet weak var lblSuitNumber: UILabel!
    
    @IBOutlet weak var lblLocationOfCar: UILabel!
    
    @IBOutlet weak var lblDateAndTime: UILabel!
    
    @IBOutlet weak var coordinateLabel: UILabel!
    
    var parking:Parking?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        let datetime = formatter.string(from: parking!.dateTime.dateValue())
        print(datetime)
        
        lblBulidingCode.text = parking?.buildingCode
        lblNumberOfHours.text = parking?.parkingHours.description
        lblSuitNumber.text = parking?.suitNumber.description
        lblDateAndTime.text = formatter.string(from: parking!.dateTime.dateValue())
        lblLocationOfCar.text = parking?.streetAddress.description
        coordinateLabel.text = "\(parking?.coordinate.latitude ?? 0.0) ° N,\(parking?.coordinate.longitude ?? 0.0)° E"
    }
    
    @IBAction func getDirection(_ sender: Any) {
        guard let s2 = storyboard?.instantiateViewController(identifier: "ParkingMap") as? MapViewController
        else {
            return
        }
        s2.parking = self.parking
        show(s2, sender: self)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        guard let s1 = storyboard?.instantiateViewController(identifier: "Home") as? HomeViewController else {
            return
        }
        
        s1.modalPresentationStyle = .fullScreen
        self.present(s1, animated: true)
        
    }
}
