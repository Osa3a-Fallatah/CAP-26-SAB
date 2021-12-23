//
//  RegisterViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import FirebaseFirestore
import FirebaseAuth
import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    @IBOutlet weak var buttonLayout: UIButton!
    
    @IBAction func registerButton(_ sender: UIButton) {
        if passwordTextField.text  == confirmTextField.text {
            signUp()
        }else{ design.useAlert(title: "Failed to register", message: "Please check your password", vc: self) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design.chageColore(view)
        // Do any additional setup after loading the view.
        buttonLayout.layer.cornerRadius = 10
        buttonLayout.layer.borderWidth = 1
    }
    
    func signUp(){
        let email = emailTextField.text!
        let pass = passwordTextField.text!
        Auth.auth().createUser(withEmail:email, password:pass) { result, error in
            if error == nil {
                self.makeFile(userId: (result?.user.uid)!)
                self.performSegue(withIdentifier: "profile", sender: self)
            }  else {
                design.useAlert(title: "Error", message: error!.localizedDescription, vc: self)
            }
        }
    }
    func makeFile(userId:String){
        let dbStore = Firestore.firestore()
        let newUser = User(uid: "", firstName: "", lastName: "", phoneNumber:0)
        do{
            let _ = try dbStore.collection("users").document(userId).setData(from: newUser)
        }catch{print(error.localizedDescription)}
    }
}
