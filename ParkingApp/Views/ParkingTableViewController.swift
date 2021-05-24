//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  ParkingTableViewController.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 18/05/21.
//

import UIKit
import MapKit

class ParkingTableViewController: UITableViewController {

    private let formatter = DateFormatter()
    
    private var viewParkingController = ViewParkingController()
    private var parkingList:[Parking] = [Parking]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .medium
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.parkingList.removeAll()
        
        self.viewParkingController.fetchUserParkings(userID: User.getInstance().id!){
            (parkingList, error) in
            if error != nil {
                print("Error View Parking: \(error!)")
            } else if parkingList != nil {
                self.parkingList.append(contentsOf: parkingList!)
                self.tableView.rowHeight = 80
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.parkingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkingCell", for: indexPath) as! ParkingTableViewCell
        
        let parking = self.parkingList[indexPath.row]
        cell.carPlateLabel.text = parking.carPlateNumber.uppercased()
        cell.dateLabel.text = "Added on \(formatter.string(from: parking.dateTime.dateValue()))"
        cell.setParkingHour(hour:Int(parking.parkingHours))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let parkingDetailNVC = storyboard?.instantiateViewController(identifier: "ParkingDetail") as? UINavigationController else{
            return
        }
        
        let parkingDetailVC = parkingDetailNVC.viewControllers[0] as! DetailScreenViewController
        parkingDetailVC.parking = self.parkingList[indexPath.row]
        parkingDetailNVC.modalPresentationStyle = .fullScreen
        show(parkingDetailNVC, sender: self)
    }
}
