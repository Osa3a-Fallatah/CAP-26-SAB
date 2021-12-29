//
//  CarImageTVC.swift
//  SAB-Cars
//
//  Created by Osama folta on 21/05/1443 AH.
//

import UIKit

class CarImageTVC: UITableViewCell {
    
    @IBOutlet weak var bigImage: UIImageView!
    
    //    func imageToData(imagUrl:String){
    //    let imageURL = URL(string:imagUrl)!
    //    URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
    //        if (error == nil) {
    //            guard let data = data else { return }
    //            DispatchQueue.main.async {
    //                self.bigImage.image = UIImage(data: data)
    //            }
    //        }
    //    }.resume()
    //}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

