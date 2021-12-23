//
//  HomePageViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import FirebaseStorage
import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit
import FirebaseFirestoreSwift

class AddCarViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let dbStore = Firestore.firestore()
    var camera = UIImagePickerController()
    var dropList = UIPickerView()
    var newCar = Car()
    let userId = Auth.auth().currentUser?.uid
   /*MARK: reference Type as Property Field in Firebase
    MARK: dbStore.collection("Ca").addDocument(data: ["mssege":dbStore.collection("Msg").document()]*/
    
    @IBOutlet weak var carimage: UIImageView!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var status: UITextView!
    @IBOutlet weak var gasType: UISegmentedControl!
    @IBOutlet weak var gearbox: UISegmentedControl!
    
    @IBAction func uploadPhotos(_ sender: Any) {
        let alart = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alart.addAction(UIAlertAction(title: "Camera", style: .default, handler: {[self] _ in
            
            self.camera.sourceType = .camera
            present(camera, animated: true, completion: nil)
        }))
        
        alart.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {[self] _ in
            
            self.camera.sourceType = .photoLibrary
            present(camera, animated: true, completion: nil)
            
        }))
        present(alart, animated: true, completion: nil)
        alart.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
  
    @IBAction func save(_ sender: Any) {
        addcar()
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        design.chageColore(view)
        camera.delegate = self
        dropList.delegate=self
        dropList.dataSource=self
        brand.inputView=dropList
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        camera.dismiss(animated: true, completion: nil)
        let image = (info[.originalImage] as! UIImage)
        self.carimage.image = image
        let data = image.jpegData(compressionQuality: 1)
        let fbStorage = Storage.storage().reference()
        let imgRef = fbStorage.child("Cars/\(userId!)/\(dbStore.collection("Cars").document().documentID).png")
        let task = imgRef.putData(data!)
        task.resume()
        
    }
    
    func observeFirestoreDB(){
        //Add Listner to watch for any changes
        dbStore.collection("Cars").addSnapshotListener { snapshot, error in
            // process the documents and update UI
            if let documents = snapshot?.documents {
                // print all data
                let _ = documents.map{print($0.data())}
            }
        }
    }
    func addcar(){
        let carid = dbStore.collection("Cars").document()
        carid.setData([
                "userID":userId!,
                "brand": brand.text!,
                "status": status.text!,
                "location": location.text!,
                "year": year.text!,
                "gasType": gasType.selectedSegmentIndex==0 ? 91:95,
                "gearbox": gearbox.selectedSegmentIndex==0 ? "auto":"manual",
                "price": price.text!] )
                    { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    
                    print("Document added" )
                    self.dbStore.collection("users").document(self.userId!).collection("cars").addDocument(data: ["car":carid])
                }
            }
    }
    func addNewCar(){
        let newCar = Car(brand: brand.text!, gasType: gasType.selectedSegmentIndex==0 ? 91:95, gearbox: gearbox.selectedSegmentIndex==0 ? "auto":"manual" , location: location.text!, status: status.text!, year: year.text!, price: price.text!, comments:nil)
       // Car(id: <#T##String#>, brand: <#T##String#>, gasType: <#T##Int#>, gearbox: <#T##String#>, location: <#T##String#>, status: <#T##String#>, year: <#T##String#>, price: <#T##String#>, comments: <#T##[Comment]?#>)
        do{
            let _ = try dbStore.collection("Cars").addDocument(from: newCar)}catch{
                design.useAlert(title: "Error Adding Document", message: " ", vc: self)
            }
    }
    var List=["chrysler","honda","mercedes-benz","ram","ford","gmc","audi"
    ,"subaru","rolls-royce", "porsche","bmw","volvo","lincoln","maserati"
    ,"infiniti", "fiat","dodge","bentley","chevrolet","land-rover","mitsubishi"
    ,"volkswagen","toyota","jeep","hyundai","cadillac","lexus","kia","mazda","nissan"]
}

extension AddCarViewController :UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         List.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        brand.text! = List[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return List[row]
    }
}
