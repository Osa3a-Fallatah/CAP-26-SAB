//
//  testViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 17/05/1443 AH.
//
import FirebaseAuth
import FirebaseFirestore
import Firebase
import UIKit

class UserCommentsVC : UIViewController ,UITableViewDelegate,UITableViewDataSource  {
    
    let db = Database.database().reference()
    let userId=Auth.auth().currentUser?.uid
    var messages = [Comment]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        readMsgs()
        design.chageColore(view)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellA", for: indexPath)
        cell.textLabel?.text=messages[indexPath.row].getmessage()
        cell.detailTextLabel?.text=messages[indexPath.row].getdate()
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = self.messages[indexPath.row]
            messages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            db.child("Comments").observe(.childAdded) { snap in
                let s = snap.key
                self.db.child("Comments").child(s).child(item.id).removeValue()
                
            }
            tableView.reloadData()
        }
    }
    
    func readMsgs(){
        
        db.child("Comments").observe(.childAdded) {snapshot , keys in
//            print("children" ,(keys ?? "nil") as String);print(snapshot.key)
            let keys=snapshot.key
            self.db.child("Comments").child(keys).observe(.childAdded ){ snapshot in
                
                let result=snapshot.value as! Dictionary<String,String>
                let sender=result["sender"]!
                let msg=result["message"]!
                let date=result["date"]!
                let user=result["userID"]!
                let id=result["MsgID"]!
                let package=Comment(sender: sender, date: date, message: msg, id: id, userID: user)
                if user == self.userId{
                    self.messages.append(package)
                    if self.messages.count==0{self.tableView.alpha=0.7}
                }
                self.tableView.reloadData()
                
                
                
            }
            
            
        }
    }
}




//MARK: END OF FIRST CLASS
//MARK: @#$
//MARK: START OF SECOND CLASS


class UserCarsVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let userId=Auth.auth().currentUser?.uid
    let dbStore = Firestore.firestore()
    var cars = [Car]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        design.chageColore(view)
        getInfo()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellB", for: indexPath) as! OwnerCarCell
        cell.labl1.text=cars[indexPath.row].brand
        cell.labl2.text="Price: \(cars[indexPath.row].price)"
        cell.imageview.imageFromURL(imagUrl: cars[indexPath.row].carImage)
        // cell.imageView?.frame = CGRect(x: 10,y: 0,width: 40,height: 40)
        return cell
    }
    func getInfo(){
        UserInfo.shared.getCars { car in
            if car.userID == self.userId{
                self.cars.append(car)
            }
            if self.cars.count==0{self.tableView.alpha=0.7}
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
}
