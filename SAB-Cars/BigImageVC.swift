//
//  BigImageVC.swift
//  SAB-Cars
//
//  Created by Osama folta on 21/06/1443 AH.
//

import UIKit

class BigImageVC: UIViewController {
    
    var link = String()
    @IBOutlet weak var bigImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bigImage.imageFromURL(imagUrl: link)
        design.chageColore(view)
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
