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
        self.view.endEditing(true)
     
    }
    
}


//MARK: - ChatTableViewDataSource

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell //Make a type cast of message cell
        cell.label.text = "\(messages[indexPath.row].body)"
        
        if message.sender == firebaseManager.getEmailofCurrentUser(){
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
            
        }else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)

        }
        
        return cell
    }
    
}


//MARK: - MessageManagerDelegate


extension ChatViewController: MessageManagerDelegate{
    
    func didUpdateMessages(_ firebaseManager: FirebaseManager, messages: [Message]) {
        
        self.messages = messages
        self.tableView.reloadData()
        
        //Scrool to the last message
        if(messages.count > 0){
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
       

    }
    
    func didFailMessageWithError(error: Error) {
        self.view.makeToast("Something happen with the messages! Please Try Again...")
    }
  
}
//MARK: - AuthenticationManagerDelegate

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
