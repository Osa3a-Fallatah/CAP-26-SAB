//
//  HomePageViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit
import SwiftUI

class AddCarViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let dbStore = Firestore.firestore()
    var camera = UIImagePickerController()
    let userId = Auth.auth().currentUser?.uid
   /*MARK: reference Type as Property Field in Firebase
    MARK: dbStore.collection("Ca").addDocument(data: ["mssege":dbStore.collection("Msg").document()]*/
    
    
    @IBOutlet weak var carimage: UIImageView!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var status: UITextField!
    @IBOutlet weak var gasType: UISegmentedControl!
    @IBOutlet weak var gearbox: UISegmentedControl!
    var newCar = Car()
    
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
        addddd()
      //  dbStore.collection("users").document(userId!).setData(["cars":[dbStore.collection("Cars").document()]], merge:true)
    }
    
    
    @IBAction func save(_ sender: Any) {
        newCar.addComment(newComment: Comment(id: "hellow", date: Date.now, message: "ok"))
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        design.chageColore(view)
        camera.delegate = self
        // Do any additional setup after loading the view.
        //   observeFirestoreDB()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        camera.dismiss(animated: true, completion: nil)
        carimage.image = (info[.originalImage] as! UIImage)
    }
    
    func observeFirestoreDB(){
        //Add Listner to watch for any changes
        dbStore.collection("Car").addSnapshotListener { snapshot, error in
            // process the documents and update UI
            if let documents = snapshot?.documents {
                // print all data
                let _ = documents.map{print($0.data())}
            }
        }
    }
    func addcar(){
        dbStore.collection("Cars").addDocument(data: [
                "userID":dbStore.collection("users").document(userId!), "mssege":dbStore.collection("Msg").document(userId!),
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
                }
            }
    }
    func addddd(){
        let newCar = Car(brand: brand.text!, gasType: gasType.selectedSegmentIndex==0 ? 91:95, gearbox: gearbox.selectedSegmentIndex==0 ? "auto":"manual" , location: location.text!, status: status.text!, year: year.text!, price: price.text!, comments:[Comment(id: userId!, date: Date.now, message: "hello")])
        do{
            let _ = try dbStore.collection("Cars").addDocument(from: newCar)}catch{
                design.useAlert(title: "Document added", message: "ok", vc: self)
            }
    }
}

