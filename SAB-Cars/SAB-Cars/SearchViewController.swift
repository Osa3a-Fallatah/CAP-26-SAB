//
//  SearchViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 02/06/1443 AH.
//

import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate{
    var cars = [Car]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        search.delegate = self
        design.chageColore(view.self)
        UserInfo.shared.getCars { car in
            if car.brand == "Toyota"{
                self.cars.append(car)
                print(self.cars.count)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var search: UISearchBar!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        UserInfo.shared.getCars { car in
            if car.brand == searchText {
                print(car.price,car.kilometeRreading)
            }
        }
    }

}
