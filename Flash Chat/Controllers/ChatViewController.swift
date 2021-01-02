//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by João Victor Ipirajá de Alencar on 01/01/21.
//

import UIKit
import Firebase
import Toast_Swift

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    @IBAction func sendPressed(_ sender: UIButton) {
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }

    @IBAction func logOutPressed(_ sender: Any) {
    
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        
      self.view.makeToast("You have been logged out of your account")
        
        navigationController?.popToRootViewController(animated: true)
        
    } catch let signOutError as NSError {
        self.view.makeToast("Some error happened! Try later")
    }
    }
    
}
