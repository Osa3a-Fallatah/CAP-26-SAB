//
//  HomePageViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddCarViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var camera = UIImagePickerController()
    var dropList = UIPickerView()
    var imgUrl = String()
    var imgData = Data()
    let userId = Auth.auth().currentUser?.uid
    let dbStore = Firestore.firestore()
    var newCar = Car()
    /*MARK: reference Type as Property Field in Firebase
     MARK: dbStore.collection("Ca").addDocument(data: ["mssege":dbStore.collection("Msg").document()]*/
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var testbutton: UIButton!
    @IBOutlet weak var carimage: UIImageView!
    @IBOutlet weak var kmReading: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var status: UITextView!
    @IBOutlet weak var gasType: UISegmentedControl!
    @IBOutlet weak var gearbox: UISegmentedControl!
    
    @IBAction func forPicker(_ sender: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
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
        if imgData.isEmpty == false{
            extractedFunc(imgData)
        }else{design.useAlert(title: "Error", message: "Please Check Your Info", vc: self)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design.chageColore(view)
        camera.delegate = self
        dropList.delegate=self
        dropList.dataSource=self
        brand.inputView=dropList
        // Do any additional setup after loading the view.
        getCar()
    }
    
    fileprivate func extractedFunc(_ data: Data?) {
        self.view.alpha = 0.4
        self.view.isUserInteractionEnabled = false
        self.activityIndicatorView.isHidden = false
        self.activityIndicatorView.startAnimating()
        let fbStorage = Storage.storage().reference()
        let imgRef =
        // child(cars/uid/carid.png)
        fbStorage.child("Cars/\(userId!)/\(dbStore.collection("Cars").document().documentID).png")
        
        imgRef.putData(data!, metadata: nil) { metadata, error in
            imgRef.downloadURL { url, error in
                self.imgUrl = (url?.absoluteString) as! String
                //MARK: update or add
                if self.newCar.id!.isEmpty == true{self.addNewCar()}
                else{self.updateNewCar1()}
                DispatchQueue.main.async {
                    self.view.alpha = 1
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.isHidden = true
                    self.view.isUserInteractionEnabled = true
                    self.savedDocAlert()
                }
            }
        }.resume()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        camera.dismiss(animated: true, completion: nil)
        let image = (info[.originalImage] as! UIImage)
        self.carimage.image = image
        imgData = image.jpegData(compressionQuality: 0.1)!
    }
   
    func updateNewCar1(){
        let carPrice = Int(price.text!) ?? 1
        let kilometeRreading = Int(kmReading.text!) ?? 1
        let carToUpdate = Car(brand: brand.text!, gasType: gasType.selectedSegmentIndex==0 ? "Gasoline":"Diesel", kilometeRreading: kilometeRreading, gearbox: gearbox.selectedSegmentIndex==0 ? "auto":"manual", location: location.text!, status: status.text!, year: year.text!, price: carPrice, carImage: imgUrl, userID: userId!)
        
        do{
            let carid = dbStore.collection("Cars").document(newCar.id!)
            try carid.setData(from: carToUpdate)}catch{
                design.useAlert(title: "Error Adding Document", message: " ", vc: self)
            }
    }
    
    func addNewCar(){
         
        let carPrice = Int(price.text!) ?? 0
        let kilometeRreading = Int(kmReading.text!) ?? 0
        let newCar = Car(brand: brand.text!, gasType: gasType.selectedSegmentIndex==0 ? "Gasoline":"Diesel", kilometeRreading: kilometeRreading, gearbox: gearbox.selectedSegmentIndex==0 ? "auto":"manual", location: location.text!, status: status.text!, year: year.text!, price: carPrice, carImage: imgUrl, userID: userId!)
      
        
        do{
            print("added succesfully")
            let _ = try dbStore.collection("Cars").addDocument(from: newCar)}catch{
                design.useAlert(title: "Error Adding Document", message: " ", vc: self)
            }
    }
    func getCar(){
        brand.text=newCar.brand
        gasType.selectedSegmentIndex=newCar.gasType=="Gasoline" ? 0:1
        gearbox.selectedSegmentIndex=newCar.gearbox=="auto" ? 0:1
        location.text=newCar.location
        status.text=newCar.status
        year.text=newCar.year
        price.text=String(newCar.price)
        kmReading.text=String(newCar.kilometeRreading)
    }
    var List=["Chrysler","Honda","Mercedes-benz","Ram","Ford","Gmc","Audi"
              ,"Subaru","Rolls-royce", "Porsche","Bmw","Volvo","Lincoln","Maserati"
              ,"Infiniti", "Fiat","Dodge","Bentley","Chevrolet","Land-rover","Mitsubishi"
              ,"Volkswagen","Toyota","Jeep","Hyundai","Cadillac","Lexus","Kia","Mazda","Nissan","Genesis","Isuzu","Porsche","Suzuki","Hummer","Mercury", "Geely", "Daihatsu","Jaguar" ,"Bentley" ,"Peugeot", "Seat", "Chery", "Citroen","Ferrari", "Skoda", "Opel","BYD" ,"FAW", "GreatWall", "GAC", "Haval", "Tesla", "Baic", "JAC", "McLaren", "MAXUS"]
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
    func savedDocAlert(){
               let alert = UIAlertController(title: "Successfully Added", message: "", preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                 let out =  self.storyboard?.instantiateViewController(withIdentifier: "homepage") as! CarsViewController
                   self.navigationController?.pushViewController(out, animated: false)
                        }))
               self.present(alert, animated: true, completion: nil)
    }
}
