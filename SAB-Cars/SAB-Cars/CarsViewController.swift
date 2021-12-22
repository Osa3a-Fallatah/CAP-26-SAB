//
//  ViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseFirestore
import UIKit

class CarsViewController: UIViewController {
    
    let dbStore = Firestore.firestore()
    var cars = [Car]()
    
    
    @IBAction func updateProfile(_ sender: Any) {
        
    }
    
    @IBOutlet weak var showname: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        getInfo()
        getUserName()
    }
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
    }
}
extension CarsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("------------------\(cars.count)--------------")
        return  cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.price.text = String(cars[indexPath.item].price)
        cell.location.text = cars[indexPath.row].location
        cell.gasType.text = String(cars[indexPath.row].gasType)
        cell.gerbox.text = cars[indexPath.row].gearbox
        cell.brand.text = cars[indexPath.row].brand
        cell.status.text = cars[indexPath.row].status
        //cell.status.text = car[indexPath.row].id
        cell.viewShape.layer.cornerRadius = 20
        cell.carphoto.layer.cornerRadius = 15
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indx = cars[indexPath.row].id
        print(indx)
        let showvc = (storyboard?.instantiateViewController(withIdentifier: "carChat"))! as! CommentsViewController
        showvc.chatRoom = indx
        navigationController?.pushViewController(showvc, animated: true)
    }
    
    func getInfo(){
        let car = dbStore.collection("Cars")
        car.addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // print("\(document.documentID) => \(document.data())")
                    let values = document.data()
                    
                    let id = document.documentID
                    let gasType = values["gasType"] as! Int
                    let brand = values["brand"] as! String
                    let year = values["year"] as! String
                    let price = values["price"] as! String
                    let gearbox = values["gearbox"] as! String
                    let location = values ["location"] as! String
                    let status = values["status"] as! String
                    
                    let car = Car(id: id, brand: brand, gasType: gasType, gearbox: gearbox, location: location, status: status, year: year, price: price, comments: nil)
                    
                    self.cars.append(car)
                    
                }
                DispatchQueue.main.async {
                    self.table.reloadData()
                }}
        }
        
    }
    func getUserName(){
        
        dbStore.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments { snapshot, err in
                guard let snapshot = snapshot else { return }
                let data = snapshot.documents.first!.data()
                let FN = (data["firstName"]!) as! String
                let LN = (data["LastName"]!) as! String
                //                  for doc in snapshot.documents {
                //                   print(doc.data())    }
                //                self.showname.title = data["userName"]! as? String
                self.showname.title = "⚙️ \(FN) \(LN)"
            }
    }
    
    //MARK: not working function
    func fetchData(){
        dbStore.collection("Cars").addSnapshotListener { snapshot , err  in
            guard let doc = snapshot?.documents else{
                print("--no data--")
                return
            }
            self.cars = doc.compactMap{ (queryDoc)  -> Car? in
                print(self.cars)
                return try? queryDoc.data(as:Car.self)
            }
        }
        
    }
}
