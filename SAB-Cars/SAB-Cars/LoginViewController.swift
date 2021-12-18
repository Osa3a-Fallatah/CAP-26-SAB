//
//  LoginViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 07/05/1443 AH.
//
import Firebase
import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonLayout1: UIButton!
    
    @IBAction func logInButton(_ sender: UIButton) {
        logIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout1.layer.cornerRadius = 10
        buttonLayout1.layer.borderWidth = 1
        self.navigationItem.leftBarButtonItems?.removeAll()
        // Do any additional setup after loading the view.
                 design.chageColore(view)
//        if Auth.auth().currentUser != nil{
//            performSegue(withIdentifier: "homepage", sender: self)
//        }
   
    }
    func logIn(){
        let email = emailTextField.text!
        let pass = passwordTextField.text!
        Auth.auth().signIn(withEmail:email, password:pass) { result, error in
            if error == nil {
                self.performSegue(withIdentifier: "homepage", sender: self)
            }  else {
                design.useAlert(title: "Error", message: error!.localizedDescription, vc: self)
            }
        }
    }
    
    func useAlertWithTextField(){
        //        let alert = UIAlertController(title: "Register", message: "enter your password again", preferredStyle: UIAlertController.Style.alert)
        //        alert.addTextField { (textField) in
        //            textField.placeholder = "confirm password"
        //            textField.isSecureTextEntry = true}
        //        alert.addAction(UIAlertAction.init(title: "Cacel", style: .cancel, handler: nil))
        //        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
        //            let confirmation=alert.textFields![0]
        //            if confirmation.text == self.lbl2Password.text && self.lbl2Password.text!.count > 6{
        //                self.signUp()
        //                self.performSegue(withIdentifier: "good", sender: self)
        //                }
        //        }))
        //        self.present(alert, animated: true, completion: nil)
    }
    
}
