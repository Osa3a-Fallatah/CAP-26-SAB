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
    
    func setCellConfig(){
        
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
