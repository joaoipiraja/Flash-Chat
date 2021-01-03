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
    
    var messages:[Message] = [Message(sender: "1@2.com", body: "Hey"),Message(sender: "1@2.com", body: "Hello!")]
    
    @IBAction func sendPressed(_ sender: UIButton) {
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = K.appTitle
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }

    @IBAction func logOutPressed(_ sender: Any) {
    
    do {
      try Auth.auth().signOut()
        
        navigationController?.popToRootViewController(animated: true)
        
    } catch let signOutError as NSError {
        self.view.makeToast("Some error happened! Try later")
    }
    }
    
}


//MARK: - ChatTableViewDataSource

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier)
        cell?.textLabel?.text = "\(messages[indexPath.row].body)"
        return cell!
    }
    
    
}

extension ChatViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //break
    }
}
