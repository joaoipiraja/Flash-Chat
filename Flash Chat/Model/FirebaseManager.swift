//
//  MessageManager.swift
//  Flash Chat
//
//  Created by João Victor Ipirajá de Alencar on 03/01/21.
//

import Foundation
import Firebase
import Toast_Swift

protocol MessageManagerDelegate {
    func didUpdateMessages(_ firebaseManager: FirebaseManager, messages:[Message])
    func didFailMessageWithError(error: Error)
}

protocol AuthenticationManagerDelegate{
    func didFailAuthWithError(error: Error)
    func didAuthenticate(isAuthenticate:Bool)
}



class FirebaseManager{
    
    private var messages:[Message] = []
    private var db:Firestore = Firestore.firestore()
    private var isSignIn = false
    var delegateMessage:MessageManagerDelegate?
    var delegateAuthentication:AuthenticationManagerDelegate?
    
    func createUser(email:String?, password:String?){
        var isCreateUser = false
        if let e = email ,let p = password{
            
            Auth.auth().createUser(withEmail: e, password: p) { authResult, error in
                if let e = error{
                    self.delegateAuthentication?.didFailAuthWithError(error: e)
                    self.delegateAuthentication?.didAuthenticate(isAuthenticate: false)
                }else{
                    self.delegateAuthentication?.didAuthenticate(isAuthenticate: true)
                    print("Create User")
                }
            }
        }
        
    }
    
    func signIn(email:String?, password:String?){
        
        var isSignIn = false
        if let e = email, let p = password{
            
            Auth.auth().signIn(withEmail: e, password: p) { (user, error) in
                if let e = error{
                    self.delegateAuthentication?.didFailAuthWithError(error: e)
                    self.delegateAuthentication?.didAuthenticate(isAuthenticate: false)
                }else{
                    self.delegateAuthentication?.didAuthenticate(isAuthenticate: true)
                    print("Sign In")
                }
            }
         
        }

    }
    func signout() {
        do {
            try Auth.auth().signOut()
            
            self.delegateAuthentication?.didAuthenticate(isAuthenticate: true)
            
        } catch let signOutError{
            self.delegateAuthentication?.didFailAuthWithError(error: signOutError)
            self.delegateAuthentication?.didAuthenticate(isAuthenticate: false)
            
        }
    }
    func sendMessage(withContent messageBody:String?){
        if let mb = messageBody ,let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField:messageSender,
                K.FStore.bodyField: messageBody
            ]){ err in
                if let err = err {
                    self.delegateMessage?.didFailMessageWithError(error: err)
                }else{
                    self.loadMessages()
                }
            }
            
        }
    }
    
    
    
    func loadMessages(){
        messages = []
        db.collection(K.FStore.collectionName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                self.delegateMessage?.didFailMessageWithError(error: err)
                
            } else {
                if let snapshotsDocuments = querySnapshot?.documents{
                    for doc in snapshotsDocuments{
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            self.messages.append(Message(sender: sender, body: messageBody))
                        }
                        
                    }
                }
                self.delegateMessage?.didUpdateMessages(self, messages: self.messages)
            }
        }
    }
    
}

