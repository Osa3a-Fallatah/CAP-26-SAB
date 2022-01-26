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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout1.layer.cornerRadius = 10
        buttonLayout1.layer.borderWidth = 1
        self.navigationItem.leftBarButtonItems?.removeAll()
        design.chageColore(view)
        if Auth.auth().currentUser != nil{
            let showvc = storyboard?.instantiateViewController(withIdentifier: "homepage") as! CarsViewController
            navigationController?.show(showvc, sender: self)
        }
    }
    @IBAction func logInButton(_ sender: UIButton) {
        logIn()
    }
    
    func logIn(){
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail:email, password:pass) { result, error in
            if error == nil {
                let showvc = self.storyboard?.instantiateViewController(withIdentifier: "homepage") as! CarsViewController
                self.navigationController?.show(showvc, sender: self)
            }  else {
                design.useAlert(title: "Error", message: error!.localizedDescription, vc: self)
            }
        }
    }    
}

