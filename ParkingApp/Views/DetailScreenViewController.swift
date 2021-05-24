
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
    
    @IBOutlet weak var lblBulidingCode: UILabel!
    
    
    @IBOutlet weak var lblNumberOfHours: UILabel!
    
    @IBOutlet weak var lblSuitNumber: UILabel!
    
    @IBOutlet weak var lblLocationOfCar: UILabel!
    
    @IBOutlet weak var lblDateAndTime: UILabel!
    
    var parking:Parking?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getDirection(_ sender: Any) {
        
        print(#function,"getDirection pressed")
        
    }
    
}
