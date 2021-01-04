//
//  ViewController.swift
//  Flash Chat
//
//  Created by João Victor Ipirajá de Alencar on 01/01/21.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel:CLTypingLabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleLabel.text = K.appTitle
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}


