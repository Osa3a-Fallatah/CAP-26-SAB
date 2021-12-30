//
//  design.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import Foundation
import UIKit


class design{
    
    static func chageColore(_ view: UIView!){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [

            
            UIColor(named: "viewUpColor")?.cgColor as Any,
            UIColor(named: "viewDownColor")?.cgColor as Any
        ]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
  static  func useAlert( title:String, message:String , vc:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
       vc.present(alert, animated: true, completion: nil)
     vc.present(CarsViewController(), animated: true, completion: nil)

    }
    
    func useAlertWithTextField(){
        //        let alert = UIAlertController(title: "Register", message: "enter your password again", preferredStyle: UIAlertController.Style.alert)
        //        alert.addTextField { (textField) in
        //            textField.placeholder = "confirm password"
        //            textField.isSecureTextEntry = true}
        //        alert.addAction(UIAlertAction.init(title: "Cacel", style: .cancel, handler: nil))
        //        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
        //            let confirmation=alert.textFields![0]
        //            if confirmation.text == self.lbl2Password.text && self.lbl2Password.text!.count > 6{
        //                self.signUp()
        //                self.performSegue(withIdentifier: "good", sender: self)
        //                }
        //        }))
        //        self.present(alert, animated: true, completion: nil)
    }
}
