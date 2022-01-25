//
//  SearchViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 02/06/1443 AH.
//
import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate , UICollectionViewDelegate , UICollectionViewDataSource{
    
    @IBOutlet weak var filterSeqment: UISegmentedControl!
    
    @IBOutlet weak var collection: UICollectionView!
    var cars = [Car]()
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var km: UILabel!
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var gear: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var locatin: UILabel!
    @IBOutlet weak var price: UILabel!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        cell.image.imageFromURL(imagUrl: cars[indexPath.item].carImage)
        cell.lablText.text = cars[indexPath.row].brand
        cell.lablText.layer.cornerRadius = 5
        updateInfo(carObject: cars[indexPath.row])
        return cell
    }
    
   
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
        //0 brand ,1 year ,2 location
        UserInfo.shared.getCars { car in
            if self.filterSeqment.selectedSegmentIndex == 0{
                if car.brand.lowercased().contains(searchText.lowercased()) {
                    DispatchQueue.main.async {
                        self.cars.append(car)
                        self.collection.reloadData()
                        
                    }
                }
            }else if self.filterSeqment.selectedSegmentIndex == 1{
                if car.year.contains(searchText) {
                    DispatchQueue.main.async {
                        self.cars.append(car)
                        self.collection.reloadData()
                        
                    }
                }
            }else{
                if car.location.lowercased().contains(searchText.lowercased()) {
                    DispatchQueue.main.async {
                        self.cars.append(car)
                        self.collection.reloadData()
                        
                    }
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize{
        return CGSize(width: collection.frame.width, height: collection.frame.height)
    }
    func updateInfo(carObject:Car){
        price.text = String(carObject.price)
        locatin.text = carObject.location
        gear.text = carObject.gearbox
        status.text = carObject .status
        km.text = String(carObject.kilometeRreading)
        year.text = carObject.year
        fuel.text = carObject.gasType
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
