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
}



class FirebaseManager{
    
    private var messages:[Message] = []
    private var db:Firestore = Firestore.firestore()
    private var isSignIn = false
    var delegateMessage:MessageManagerDelegate?
    var delegateAuthentication:AuthenticationManagerDelegate?
    
    
    func signIn(email:String?, password:String?)-> Bool{
        
        if let e = email, let p = password{
            do {
                try  Auth.auth().signIn(withEmail: e, password: p)
                return true
            } catch let signOutError{
                self.delegateAuthentication?.didFailAuthWithError(error: signOutError)
              
            }
        }
        return false
    }
    func signout() -> Bool{
        do {
            try Auth.auth().signOut()
            
            return true
            
        } catch let signOutError{
            self.delegateAuthentication?.didFailAuthWithError(error: signOutError)
            return false
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

