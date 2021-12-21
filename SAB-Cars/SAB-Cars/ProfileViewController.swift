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
    
    var dbStore = Firestore.firestore()
  
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneProfile: UITextField!
    
    @IBOutlet weak var save: UIButton!
    @IBAction func saveButton(_ sender: Any) {

        if ((firstName.text!.count>3)&&(lastName.text!.count>3)&&(phoneProfile.text!.count == 10)){
            let userId =  Auth.auth().currentUser!.uid
            dbStore.collection("users").document(userId).setData(["firstName" : firstName.text!,
                                                                 "phoneNumber":phoneProfile.text!,
                                                                      "LastName":lastName.text!,
                                                                 // "uid":dbStore.collection("users").document(userId)
                                                                  "uid":userId
                                                                 ])
            
//            dbStore.collection("users").addDocument(data: ["userName" : usernameProfile.text!,
//                                                      "phoneNumber":phoneProfile.text!,
//                                                           "gender":genderProfile.text!,
//                                                      "uid":userId])
            performSegue(withIdentifier: "home", sender: self)
        }else { design.useAlert(title: "Error", message: "please chek your info", vc: self)}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        save.layer.cornerRadius = 10
        save.layer.borderWidth = 1
        self.navigationItem.hidesBackButton = true
      
        // Do any additional setup after loading the view.
    }
  
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
