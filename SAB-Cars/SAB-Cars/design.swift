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
            UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).cgColor,
            UIColor(red: 0.1, green: 0.5, blue: 0.7, alpha: 0.8).cgColor
        ]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    static  func useAlert( title:String, message:String , vc:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        vc.present(CarsViewController(), animated: true, completion: nil)
        
    }
    
}
