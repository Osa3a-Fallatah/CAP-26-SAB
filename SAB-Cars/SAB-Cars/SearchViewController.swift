//
//  SearchViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 02/06/1443 AH.
//
import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate , UICollectionViewDelegate , UICollectionViewDataSource {

    var cars = [Car]()
    @IBOutlet weak var filterSeqment: UISegmentedControl!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var locatin: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var gear: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var km: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        collection.delegate = self
        design.chageColore(view.self)
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        cell.image.imageFromURL(imagUrl: cars[indexPath.item].carImage)
        cell.lablText.text = cars[indexPath.row].brand
        cell.lablText.layer.cornerRadius = 5
        
        return cell
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
        collection.reloadData()
        self.cars.removeAll()
        //0 brand ,1 year ,2 location
        UserInfo.shared.getCars { car in
            if self.filterSeqment.selectedSegmentIndex == 0{
                if car.brand.lowercased().starts(with:searchBar.text!.lowercased()) {
                    DispatchQueue.main.async {
                        self.cars.append(car)
                        self.collection.reloadData()
                        
                    }
                }
            }else if self.filterSeqment.selectedSegmentIndex == 1{
                if car.year.starts(with:searchBar.text!.lowercased()) {
                    DispatchQueue.main.async {
                        self.cars.append(car)
                        self.collection.reloadData()
                        
                    }
                }
            }else{
                if car.location.lowercased().starts(with:searchBar.text!.lowercased()) {
                    DispatchQueue.main.async {
                        self.cars.append(car)
                        self.collection.reloadData()
                        
                    }
                }
            }
        }
        searchBar.resignFirstResponder()
    }
}
extension SearchViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.width, height: 280)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showvc = storyboard?.instantiateViewController(withIdentifier: "Connect") as! BigImageVC
        showvc.link = cars[indexPath.row].carImage
        navigationController?.show(showvc, sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 1) {

            self.animationText(lable: self.price)
            self.animationText(lable: self.locatin)
            self.animationText(lable: self.km)
            self.animationText(lable: self.year)
            self.animationText(lable: self.fuel)
            self.animationText(lable: self.status)
            self.animationText(lable: self.gear)
            self.updateInfo(carObject:self.cars[indexPath.row])
        }
    }
    func animationText(lable:UILabel){
        let x = lable.frame.width*2
        let y = lable.frame.height*2
        lable.frame.size = CGSize(width: x, height: y)
    }
}
