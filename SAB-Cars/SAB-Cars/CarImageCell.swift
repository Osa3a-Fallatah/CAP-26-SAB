//
//  CarImageTVC.swift
//  SAB-Cars
//
//  Created by Osama folta on 21/05/1443 AH.
//

import UIKit

class CarImageCell: UITableViewCell {
    
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var carDescription: UILabel!
    @IBOutlet weak var bigImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

