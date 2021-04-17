//
//  ViewController.swift
//  Mola
//
//  Created by 김민창 on 2021/04/17.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var loginButtonLabel: UILabel!
    @IBOutlet weak var signUpButtonLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var forgotLabel: UILabel!
    
    @IBAction func loginTapView(_ sender: UITapGestureRecognizer) {
        print("login")
    }
    
    @IBAction func signUpTapView(_ sender: UITapGestureRecognizer) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let loginTapGesture: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.loginTapView(_:)))
        self.loginButtonLabel.isUserInteractionEnabled = true
        self.loginButtonLabel.addGestureRecognizer(loginTapGesture)
        
        let signUpTapGesture: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.signUpTapView(_:)))
        self.signUpButtonLabel.isUserInteractionEnabled = true
        self.signUpButtonLabel.addGestureRecognizer(signUpTapGesture)
    }


}

