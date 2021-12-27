//
//  ViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseFirestore
import UIKit

class CarsViewController: UIViewController {
    let db = Database.database().reference()
    let dbStore = Firestore.firestore()
    var cars = [Car]()
    var carsImages=[UIImage]()
    var owner = ""
    var canDelet = false
    
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
        return  cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        let car=cars[indexPath.row]
        cell.updateButton.isHidden = true
        cell.updatecell(item: car)
        cell.viewShape.layer.cornerRadius = 20
        cell.carphoto.layer.cornerRadius = 15
        //MARK: convert img
        let imageURL = URL(string:cars[indexPath.row].carimg)!
             URLSession.shared.dataTask(with: imageURL)
        let data = try? Data(contentsOf: imageURL)
        cell.carImg.image = UIImage(data: data!)
      if canDelet == true {
          cell.updateButton.isHidden = false
          cell.updateButton.tag = indexPath.row
          cell.updateButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
      }
        return cell
    }
    
    @objc func buttonAction(sender:UIButton){
         let indexpath = IndexPath(row: sender.tag, section: 0)
        let cell = cars[indexpath.row]
         let next:AddCarViewController=self.storyboard?.instantiateViewController(withIdentifier: "next") as! AddCarViewController
         self.navigationController?.pushViewController(next, animated: true)
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indx = cars[indexPath.row].id
        let imageCar = cars[indexPath.row].carimg
    
        let showvc = (storyboard?.instantiateViewController(withIdentifier: "carChat"))! as! CommentsViewController
        showvc.chatRoom = indx
        showvc.photo = imageCar
        navigationController?.pushViewController(showvc, animated: true)
    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, handler in
//            guard  self.canDelet == true else { return }
//            let itemToDelete = self.cars[indexPath.row]
//            self.dbStore.collection("Cars").document(itemToDelete.id).delete()
//            self.db.child("Comments").child(itemToDelete.id).removeValue()
//            self.getInfo()
//            tableView.reloadData()
//            }
// 
//        return UISwipeActionsConfiguration(actions: [actionDelete])
//    }
//    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        .delete
//    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard  self.canDelet == true else { return }
        if editingStyle == .delete {
            let itemToDelete = self.cars[indexPath.row]
            cars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.dbStore.collection("Cars").document(itemToDelete.id).delete()
            self.db.child("Comments").child(itemToDelete.id).removeValue()
            self.getInfo()
            tableView.reloadData()
        }
    }
    
    func getInfo(){
        let car = dbStore.collection("Cars")
        car.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.cars.removeAll()
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
                    let carimg = values["carimg"] as! String
                    let userid = values["userID"] as! String
                    
                    let car = Car(id: id, brand: brand, gasType: gasType, gearbox: gearbox, location: location, status: status, year: year, price: price,carimg: carimg ,comments: nil)
                    self.owner = userid
                    self.cars.append(car)
                    
                    if userid == Auth.auth().currentUser?.uid{
                        self.canDelet=true
                    }
                    
                    
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
                let LN = (data["lastName"]!) as! String
                
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
