//
//  HeaderTableViewCell.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//

import UIKit
import FirebaseAuth

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

        viewShape.layer.cornerRadius = 20
        carphoto.layer.cornerRadius = 15
    }
    
    func addObject(item:Car){
        price.text!=String(item.price)
        location.text!=item.location
        status.text!=item.status
        gerbox.text!=item.gearbox
        gasType.text!=String(item.gasType)
        brand.text!=item.brand
    }
    func addImage(Link:String){
        let imageURL = URL(string:Link)!
        URLSession.shared.dataTask(with: imageURL)
        let data = try? Data(contentsOf: imageURL)
        carImg.image = UIImage(data: data!)
    }
}
