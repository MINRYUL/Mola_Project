//
//  ViewController.swift
//  Mola
//
//  Created by 김민창 on 2021/04/17.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var loginButtonLabel: UILabel!
    @IBOutlet weak var signUpButtonLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var forgotLabel: UILabel!
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var tapIdTextField: Bool = false
    var tapPasswordTextField: Bool = false
    
    @IBAction func loginTapView(_ sender: UITapGestureRecognizer) {
        print("login")
    }
    
    @IBAction func signUpTapView(_ sender: UITapGestureRecognizer) {
        let singUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpStoryBoard")
        self.navigationController?.pushViewController(singUpVC!, animated: true)
    }
    
    
    @IBAction func idTapView(_ sender: UITapGestureRecognizer) {
        self.idLabel.isHidden = true
        self.idText.isHidden = false
        self.tapIdTextField = true
        self.idText.text = self.idLabel.text
    }
    
    @IBAction func passwordTapView(_ sender: UITapGestureRecognizer) {
        self.passwordLabel.isHidden = true
        self.passwordText.isHidden = false
        self.tapPasswordTextField = true
        self.passwordText.text = self.passwordLabel.text
    }
    
    func textFieldShouldReturn(_ Text: UITextField) -> Bool {
        if tapIdTextField == true {
            Text.resignFirstResponder()
            self.idText.isHidden = true
            self.idLabel.isHidden = false
            tapIdTextField = false
            self.idLabel.text = self.idText.text
        } else if tapPasswordTextField == true {
            Text.resignFirstResponder()
            self.passwordText.isHidden = true
            self.passwordLabel.isHidden = false
            tapPasswordTextField = false
            self.passwordLabel.text = self.passwordText.text
        }
        return true
    }
    
    func initGesture() {
        let loginTapGesture: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.loginTapView(_:)))
        self.loginButtonLabel.isUserInteractionEnabled = true
        self.loginButtonLabel.addGestureRecognizer(loginTapGesture)
        
        let signUpTapGesture: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.signUpTapView(_:)))
        self.signUpButtonLabel.isUserInteractionEnabled = true
        self.signUpButtonLabel.addGestureRecognizer(signUpTapGesture)

        self.idText.delegate = self
        self.idText.isHidden = true
        let idTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.idTapView(_:)))
        self.idLabel.isUserInteractionEnabled = true
        idTapGesture.numberOfTapsRequired = 1
        self.idLabel.addGestureRecognizer(idTapGesture)
        
        self.passwordText.delegate = self
        self.passwordText.isHidden = true
        let passwordTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.passwordTapView(_:)))
        self.passwordLabel.isUserInteractionEnabled = true
        passwordTapGesture.numberOfTapsRequired = 1
        self.passwordLabel.addGestureRecognizer(passwordTapGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        initGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }


}

