//
//  ChatTableViewCell.swift
//  SAB-Cars
//
//  Created by Osama folta on 14/05/1443 AH.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var viewshap: UIView!    
    @IBOutlet weak var lablForText: UILabel!
    @IBOutlet weak var lableForName: UILabel!
    @IBOutlet weak var lableForDate: UILabel!
    
    func setData(name:String,msg:String,date:String){
        lableForName.text!=name
        lablForText.text!=msg
        lableForDate.text=date
        viewshap.layer.cornerRadius = 20
    }
}

