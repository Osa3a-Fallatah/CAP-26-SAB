//
//  SearchViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 02/06/1443 AH.
//

import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate , UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionVC
        cell.image.imageFromURL(imagUrl: cars[indexPath.item].carImage)
        cell.lablText.text = cars[indexPath.row].brand
        cell.lablText.layer.cornerRadius = 5
        cell.lablText.shadowColor = .blue
        return cell
    }
    
   
    @IBOutlet weak var collection: UICollectionView!
    var cars = [Car]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        search.delegate = self
        design.chageColore(view.self)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var search: UISearchBar!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        collection.reloadData()
        self.cars.removeAll()

        UserInfo.shared.getCars { car in
            if car.brand.contains(searchText) {
                DispatchQueue.main.async {
                    self.cars.append(car)
                    self.collection.reloadData()
                    
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize{
        return CGSize(width: collection.frame.width, height: collection.frame.height)
    }
}
