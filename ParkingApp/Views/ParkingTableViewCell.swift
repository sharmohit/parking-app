//  Group: Project Groups 12
//  Name: Mohit Sharma
//  Student ID: 101342267
//  Group Member: Javtesh Singh Bhullar
//  Member ID: 101348129
//
//  ParkingTableViewCell.swift
//  ParkingApp
//
//  Created by Mohit Sharma on 24/05/21.
//

import UIKit

class ParkingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carPlateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setParkingHour(hour:Int) {
        
        let text = "Parked for"
        
        if hour > 1 {
            self.hoursLabel.text = "\(text) \(hour) hrs"
        } else {
            self.hoursLabel.text = "\(text) \(hour) hr"
        }
    }
}
