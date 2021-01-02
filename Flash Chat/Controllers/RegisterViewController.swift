//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by João Victor Ipirajá de Alencar on 01/01/21.
//

import UIKit
import Firebase
import Toast_Swift

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func ToastMessage(){
        
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        if let email = emailTextfield.text ,let password = passwordTextfield.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.view.endEditing(true)
                    self.emailTextfield.text = ""
                    self.passwordTextfield.text = ""
                    self.view.makeToast(e.localizedDescription)

                }else{
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
            }
        }
        
       
    }
    


}

