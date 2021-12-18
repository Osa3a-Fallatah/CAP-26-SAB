//
//  ViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import FirebaseAuth
import FirebaseFirestore
import UIKit
import nanopb

class CarsViewController: UIViewController {
    
    @IBAction func signOut(_ sender: Any) {
        do {   try! Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        }
    }
    let dbStore = Firestore.firestore()
    var car = [Car]()
    
    @IBOutlet weak var showname: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        getInfo()
        getUserName()
    }

}
extension CarsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  car.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.price.text = String(car[indexPath.item].price)
        cell.location.text = car[indexPath.row].location
        cell.gasType.text = String(car[indexPath.row].gasType)
        cell.gerbox.text = car[indexPath.row].gearbox
        cell.brand.text = car[indexPath.row].brand
        cell.status.text = car[indexPath.row].status
        cell.viewShape.layer.cornerRadius = 20
        cell.carphoto.layer.cornerRadius = 15
        if dbStore.collection("users").document().documentID == Auth.auth().currentUser!.uid{
            cell.updateButton.isHidden = true
        }
        print("------------------\(car.count)--------------")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "carChat", sender: self)
    }
    
    func getInfo(){
        let car = dbStore.collection("Cars")
        
        //let uid = Auth.auth().currentUser?.uid
        
        car.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let values = document.data()
                                             if let brand = values["brand"] {
                                                 print (brand)
                                          }
                    let gasType = values["gasType"]
                    let brand = values["brand"]
                    let year = values["year"]
                    let price = values["price"]
                    let gearbox = values["gearbox"]
                    let location = values ["location"]
                    let status = values["status"]
                    
                    

                    let getcar = Car(brand: brand as! String, gasType: gasType as! Int, gearbox: gearbox as! String, location: location as! String, status: status as! String, year: year as! String, price: price as! String, comments: nil)
                    var carfbdb = Car()
                    carfbdb.year=year as! String
                    carfbdb.price=price as! String
                   carfbdb.brand=brand as! String
                    carfbdb.gasType=gasType as! Int
                    
                    self.car.append(getcar)
                    
                }
                self.table.reloadData()
            }
        }
        
    }
    func getUserName(){
        
        dbStore.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments { snapshot, err in
                guard let snapshot = snapshot else { return }
                let data = snapshot.documents.first!.data()
                print (data["userName"]!)
                
//                  for doc in snapshot.documents {
//                   print(doc.data())    }
                self.showname.title = data["userName"]! as? String
             
            }
        
    }
}
