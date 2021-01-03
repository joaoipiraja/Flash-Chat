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
    var firebaseManager = FirebaseManager()
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager.delegateAuthentication = self
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {

        if firebaseManager.signIn(email: emailTextfield.text, password: passwordTextfield.text){
            self.performSegue(withIdentifier: K.loginSegue, sender: self)
        }
    }
   


}

extension LoginViewController: AuthenticationManagerDelegate{
    
    func didFailAuthWithError(error: Error) {
        self.view.makeToast("Something Happen:\(error.localizedDescription)!")
    }
    
}
