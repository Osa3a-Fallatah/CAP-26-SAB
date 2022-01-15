//
//  ProfileViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    let dbStore = Firestore.firestore()
    let userId =  Auth.auth().currentUser!.uid
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneProfile: UITextField!
    @IBOutlet weak var save: UIButton!
    
    @IBOutlet weak var visiblePhoneNumber: UISegmentedControl!
    @IBAction func saveButton(_ sender: Any) {
        
        if ((firstName.text!.trimmingCharacters(in: .whitespaces)=="" || (firstName.text!.count<3)) &&
            (lastName.text?.trimmingCharacters(in: .whitespaces)=="") || (lastName.text!.count<3)  &&
            (phoneProfile.text!.count == 10) || (phoneProfile.text?.trimmingCharacters(in: .whitespaces)=="")){
            design.useAlert(title: "Error", message: "please chek your info", vc: self)
            
        }else {
            let newUser = User(uid: userId, firstName: firstName.text!, lastName: lastName.text!, phoneNumber: Int(phoneProfile.text!) ?? 0,showPhone: visiblePhoneNumber.selectedSegmentIndex==0 ? false:true)
            do{
                let _ = try dbStore.collection("users").document(userId).setData(from: newUser)
            }catch{print(error.localizedDescription)}
            
            performSegue(withIdentifier: "home", sender: self)
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        save.layer.cornerRadius = 10
        save.layer.borderWidth = 1
        self.navigationItem.hidesBackButton = true
        getProfile()
        // Do any additional setup after loading the view.
    }
    
    func getProfile(){
        
        dbStore.collection("users").document(userId).getDocument { snap , err  in
            guard let snap = snap else { return }
            let data = snap.data()
            let phone = (data!["phoneNumber"]) as! Int
            let  firstName = (data!["firstName"]) as! String
            let lastName = (data!["lastName"]) as! String
            
            self.firstName.text=firstName
            self.lastName.text=lastName
            self.phoneProfile.text=String(phone)
            
        }
    }

}

