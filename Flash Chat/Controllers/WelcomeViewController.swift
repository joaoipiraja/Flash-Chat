//
//  ViewController.swift
//  Flash Chat
//
//  Created by João Victor Ipirajá de Alencar on 01/01/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationTitle()
    }
    
    
}


extension WelcomeViewController{
    func animationTitle(){
        
        let titleText = self.titleLabel.text ?? ""
        self.titleLabel.text = ""
        var characterIndex:Double = 1.0
        for letter in titleText{
            
            Timer.scheduledTimer(withTimeInterval: 0.1*characterIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            
            characterIndex += 1.0
            
            
        }
    }
}

