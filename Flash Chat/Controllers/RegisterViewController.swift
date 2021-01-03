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
    var firebaseManager = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager.delegateAuthentication = self
    }
    
    
    
    @IBAction func registerPressed(_ sender: Any) {
        
        firebaseManager.createUser(email: emailTextfield.text, password: passwordTextfield.text)
    }
    
    
    
}
extension RegisterViewController:AuthenticationManagerDelegate{
    
    func didAuthenticate(isAuthenticate: Bool) {
        if(isAuthenticate){
            self.performSegue(withIdentifier: K.registerSegue, sender: self)
        }else{
            self.view.endEditing(true)
            self.emailTextfield.text = ""
            self.passwordTextfield.text = ""
        }
    }
    
    
    
    func didFailAuthWithError(error: Error) {
        self.view.makeToast(error.localizedDescription)
    }
    
    
}

