//
//  LoginViewController.swift
//  Flash Chat
//
//  Created by João Victor Ipirajá de Alencar on 01/01/21.
//


import UIKit
import Firebase
import Toast_Swift

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
      
    @IBOutlet weak var passwordTextfield: UITextField!
       
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error{
                    self?.view.endEditing(true)
                    self?.emailTextfield.text = ""
                    self?.passwordTextfield.text = ""
                    self?.view.makeToast(e.localizedDescription)
                }else{
                
                    self?.performSegue(withIdentifier: K.loginSegue, sender: self)
                  
                }
            }
        }
    }
   


}
