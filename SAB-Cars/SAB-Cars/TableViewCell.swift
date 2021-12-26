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
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var gerbox: UILabel!
    @IBOutlet weak var gasType: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var carphoto: UIView!
    @IBOutlet weak var viewShape: UIView!
    
    @IBOutlet weak var carImg: UIImageView!
    
    func setCarData(price:String ,location:String ,status:String, gerbox:String ,gasType:String, brand:String ){
        self.price.text!=price
        self.location.text!=location
        self.status.text!=status
        self.gerbox.text!=gerbox
        self.gasType.text!=gasType
        self.brand.text!=brand
    }
    func updatecell(item:Car){
        price.text!=String(item.price)
        location.text!=item.location
        status.text!=item.status
        gerbox.text!=item.gearbox
        gasType.text!=String(item.gasType)
        brand.text!=item.brand
    }
}
