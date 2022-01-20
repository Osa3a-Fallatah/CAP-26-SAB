//
//  HeaderTableViewCell.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var kmReading : UILabel!
    @IBOutlet weak var gerbox: UILabel!
    @IBOutlet weak var gasType: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var carphoto: UIView!
    @IBOutlet weak var viewShape: UIView!
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var carImg: UIImageView!
 
    
    func setCellConfig(){

        viewShape.layer.cornerRadius = 20
        carphoto.layer.cornerRadius = 15
    }
    
    func update(item:Car){
        price.text = String(item.price)
        location.text = item.location
        kmReading.text = String(item.kilometeRreading)
        gerbox.text = item.gearbox
        gasType.text = item.gasType
        brand.text = item.brand
        year.text = item.year
    }
}
