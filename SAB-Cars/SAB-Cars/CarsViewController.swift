//
//  ViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import FirebaseAuth
import FirebaseFirestore
import UIKit

class CarsViewController: UIViewController {
    
    let dbStore = Firestore.firestore()
    var comments = [Comment]()
    var car = [Car]()
    
    @IBOutlet weak var showname: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
       // getInfo()
        
                }
    override func viewWillAppear(_ animated: Bool) {
        let userId =  Auth.auth().currentUser!.uid
        let aLovelaceDocumentReference = dbStore.collection("users")
        print(aLovelaceDocumentReference)
    }
}
extension CarsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        car.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.price.text = String(car[indexPath.item].price)
        cell.location.text = car[indexPath.row].year
        cell.infoLable.text = car[indexPath.row].brand
        cell.viewShape.layer.cornerRadius = 15
        cell.carphoto.layer.cornerRadius = 17
        print("------------------\(car.count)--------------")
        return cell
    }
    
    func getInfo(){
        let FSDB = Firestore.firestore().collection("Car")
        FSDB.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                 } else {
                     for document in querySnapshot!.documents {
                         print("\(document.documentID) => \(document.data())")
                         let values = document.data()
//                         if let brand = values["brand"] {
//                             print (brand)
//                         }
        
                         let brand = values["brand"]!
                         let year = values["year"]!
                         let price = values["price"]!
                     
                    
                        let carfbdb = Car()
                         carfbdb.year=year as! String
                         carfbdb.price=price as! String
                         carfbdb.brand=brand as! String
                    
                         self.car.append(carfbdb)
                         
                     }
                     self.table.reloadData()
                }
        }
        
        
    }
}
