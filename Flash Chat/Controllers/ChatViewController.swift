//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by João Victor Ipirajá de Alencar on 01/01/21.
//

import UIKit



class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var firebaseManager = FirebaseManager()
    var messages = [Message]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        firebaseManager.delegateMessage = self
        firebaseManager.delegateAuthentication = self
        title = K.appTitle
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        firebaseManager.loadMessages()
       
    }
    
   
    
    @IBAction func logOutPressed(_ sender: Any) {
        firebaseManager.signout()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        firebaseManager.sendMessage(withContent: messageTextfield.text)
        messageTextfield.text = ""
    }
    
}


//MARK: - ChatTableViewDataSource

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell //Make a type cast of message cell
        cell.label.text = "\(messages[indexPath.row].body)"
        return cell
    }
    
}

//MARK: - ChatTableViewDelegate

extension ChatViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //break
    }
}

//MARK: - MessageManagerDelegate


extension ChatViewController: MessageManagerDelegate{
    
    func didUpdateMessages(_ firebaseManager: FirebaseManager, messages: [Message]) {
        self.messages = messages
        self.tableView.reloadData()

    }
    
    func didFailMessageWithError(error: Error) {
        self.view.makeToast("Something happen with the messages! Please Try Again...")
    }
  
}

extension ChatViewController: AuthenticationManagerDelegate{
    
    func didAuthenticate(isAuthenticate: Bool) {
        if(isAuthenticate){
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    func didFailAuthWithError(error: Error) {
        self.view.makeToast(error.localizedDescription)
    }
}
