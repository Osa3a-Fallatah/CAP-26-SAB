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

    var cars = [Car]()
    let dbStore = Firestore.firestore()
    let db = Database.database().reference()

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
        design.chageColore(self.view)
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    
      
        UserInfo.shared.getCars { car in
            self.cars.append(car)
              DispatchQueue.main.async { self.table.reloadData() }
        }
        UserInfo.shared.getUserName { user in
            self.showname.title=("\(user.firstName ) \(user.lastName)")
       }
       
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
        
        cell.update(item: car)
        cell.setCellConfig()
        
        cell.updateButton.isHidden = car.userID != Auth.auth().currentUser?.uid
        cell.updateButton.tag = indexPath.row
        cell.updateButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        cell.carImg.imageFromURL(imagUrl: cars[indexPath.row].carImage)
        return cell
    }
    
    @objc func buttonAction(sender:UIButton){
        
        let indexpath = IndexPath(row: sender.tag, section: 1)
        let cell = cars[indexpath.row]
        let next:AddCarViewController=self.storyboard?.instantiateViewController(withIdentifier: "next") as! AddCarViewController
        next.newCar = cell
        self.navigationController?.pushViewController(next, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indx = cars[indexPath.row].id
        let imageCar = cars[indexPath.row].carImage
        
        let showvc = (storyboard?.instantiateViewController(withIdentifier: "carChat"))! as! CommentsViewController
        showvc.chatRoom = indx!
        showvc.photo = imageCar
        showvc.desc=cars[indexPath.row].status
        navigationController?.pushViewController(showvc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard  cars[indexPath.row].userID == Auth.auth().currentUser?.uid else { return }
        if editingStyle == .delete {
            let itemToDelete = self.cars[indexPath.row]
            cars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.dbStore.collection("Cars").document(itemToDelete.id!).delete()
            self.db.child("Comments").child(itemToDelete.id!).removeValue()
            tableView.reloadData()
        }
    }
    
 
 
}

//MARK: convert img
var imgCache = NSCache<NSString,AnyObject>()

extension UIImageView {
    func imageFromURL(imagUrl:String) {
        let imageURL = URL(string:imagUrl)!
        
        if let imgCached = imgCache.object(forKey: imagUrl as NSString) {
            self.image = imgCached as! UIImage
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if (error == nil) {
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    imgCache.setObject(self.image!, forKey: imagUrl as NSString)
                }
            }
        }.resume()
    }
}
extension UITextField {
    //@Change placeholder color
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
