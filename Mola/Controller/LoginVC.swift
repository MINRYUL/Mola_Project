//
//  ViewController.swift
//  Mola
//
//  Created by 김민창 on 2021/04/17.
//

import UIKit
import SnapKit
import Then

class LoginVC: UIViewController {
    static let NotificationDone = NSNotification.Name(rawValue: "Main")
    let loginRequestURL: String = "http://13.209.232.235:8080/login/"
    
    var email : String?
    var password : String?
    
    private var titleimage = UIImageView().then {
        $0.image = UIImage(named: "PriceLabelpng")
        $0.contentMode = .scaleAspectFit
    }
    private var idField = SloyTextField().then {
        $0.placeholder = "이메일"
        $0.tintColor = .systemTeal
    }
    private var pwField = SloyTextField().then {
        $0.placeholder = "비밀번호"
        $0.tintColor = .systemTeal
        $0.isSecureTextEntry = true
    }
    private var loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemTeal
        $0.layer.cornerRadius = 10
    }
    private var signUpLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemBlue
        $0.text = "회원이 아니신가요?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupLabelTap()
        self.setupMainLayoutWithSnapKit()
    }
    
    private func setupLabelTap() {
        let SignUpLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.signUpLabelTapped(_:)))
        self.signUpLabel.isUserInteractionEnabled = true
        self.signUpLabel.addGestureRecognizer(SignUpLabelTap)
    }
    
    private func setupMainLayoutWithSnapKit() {
        view.backgroundColor = .white
        view.addSubview(titleimage)
        view.addSubview(idField)
        view.addSubview(pwField)
        view.addSubview(loginButton)
        view.addSubview(signUpLabel)
        
        titleimage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.leading.equalToSuperview().offset(3)
            make.trailing.equalToSuperview().offset(-3)
            make.height.equalTo(150)
        }
        
        idField.snp.makeConstraints { make in
            make.top.equalTo(titleimage.snp.bottom).offset(90)
            make.leading.equalTo(titleimage.snp.leading).offset(35)
            make.trailing.equalTo(titleimage.snp.trailing).offset(-35)
            make.height.equalTo(55)
        }
        pwField.snp.makeConstraints { make in
            make.top.equalTo(idField.snp.bottom).offset(16)
            make.leading.equalTo(idField.snp.leading)
            make.trailing.equalTo(idField.snp.trailing)
            make.height.equalTo(55)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(pwField.snp.bottom).offset(16)
            make.leading.equalTo(pwField.snp.leading).offset(-5)
            make.trailing.equalTo(pwField.snp.trailing).offset(5)
            make.height.equalTo(44)
            loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(3)
            make.leading.equalTo(loginButton.snp.leading).offset(230)
            make.trailing.equalTo(loginButton.snp.trailing).offset(0)
            make.height.equalTo(44)
        }
        
        self.idField.tag = 1
        self.idField.delegate = self
        self.idField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        
        self.pwField.tag = 2
        self.pwField.delegate = self
        self.pwField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }
}

extension LoginVC : UITextFieldDelegate {
    @objc
    private func valueChanged(_ textField: SloyTextField) {
        switch textField.tag{
        case (1):
            self.email = textField.text
        case (2):
            self.password = textField.text
        default:
            return
        }
    }
    
    @objc func loginButtonAction(sender: UIButton!) {
        print("touch login button")
        var checkInput : Bool! = true
        var errorString : String! = "알 수 없는 오류"
        
        if let email : String = self.email {
            print(email)
        } else {
            checkInput = false
            errorString = "이메일 형식이 잘못되었습니다."
        }
        
        if let password : String = self.password {
            print(password)
        } else {
            checkInput = false
            errorString = "비밀번호를 잘못입력하였습니다."
        }
        
        if checkInput {
            let loginData : LoginData = {
                LoginData(email: self.email!, password: self.password!)
            }()
            AlamofireClient.shared.requestUserLogin(requestURL: loginRequestURL, loginData: loginData) { res in
                switch res.result{
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8){
                        if let jsonDict: [String: Any] = jsonStringToDictionary(jsonString: jsonString){
                            print(jsonDict)
                            if let status : Int = jsonDict["status"] as? Int {
                                if status >= 400{
                                    checkInput = false
                                    errorString = "아이디 비밀번호를 다시 확인해주세요"
                                }
                            } else {
                                var userInfo = UserDetail.shared
                                if let id : Int = jsonDict["id"] as? Int {
                                    userInfo.id = id
                                } else {
                                    checkInput = false
                                }
                                
                                if let email : String = jsonDict["email"] as? String {
                                    userInfo.email = email
                                } else {
                                    checkInput = false
                                }
                                
                                if let password : String = jsonDict["password"] as? String {
                                    userInfo.password = password
                                } else {
                                    checkInput = false
                                }
                                
                                if let name : String = jsonDict["name"] as? String {
                                    userInfo.name = name
                                } else {
                                    checkInput = false
                                }
                                
                                if let phonenum : String = jsonDict["phonenum"] as? String {
                                    userInfo.phonenum = phonenum
                                } else {
                                    checkInput = false
                                }
                                
                                if let point : Int = jsonDict["point"] as? Int {
                                    userInfo.point = point
                                } else {
                                    checkInput = false
                                }
                                
                                if checkInput == false{
                                    errorString = "알 수 없는 오류"
                                }
                            }
                            if checkInput {
                                NotificationCenter.default.post(name: LoginVC.NotificationDone, object: nil)
                                
                            } else {
                                DispatchQueue.main.async {
                                    let alert: UIAlertController = UIAlertController(title: "오류", message: errorString!, preferredStyle: .alert)
                                    let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
                                    alert.addAction(action)
                                    self.present(alert, animated: true)
                                }
                            }
                        }
                    }
                case .failure(let err):
                    print("err발생")
                    print(err)
                    checkInput = false
                    errorString = "요청 오류"
                }
            }
        }
        
        if checkInput == false {
            let alert: UIAlertController = UIAlertController(title: "오류", message: errorString!, preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
//        NotificationCenter.default.post(name: LoginVC.NotificationDone, object: nil)
    }
    
    @objc func signUpLabelTapped(_ sender: UITapGestureRecognizer) {
        print("labelTapped")
        let signUpVC = SignUpVC()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
