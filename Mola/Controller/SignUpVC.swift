//
//  SignUpViewController.swift
//  Mola
//
//  Created by 김민창 on 2021/04/18.
//

import UIKit
import SnapKit
import Then
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class SignUpVC: UIViewController {
    
    let signUpRequestURL: String = "http://13.209.232.235:8080/user/signup"
    
    var email : String?
    var password : String?
    var passwordCheck : String?
    var name : String?
    var phonenum : String?
    
    let signUpCategory: [SignUpCategory] = [
        SignUpCategory(name: "가입 정보", textField: [
            TextField(label: "이메일", placeHolder: "example@gmail.com", helpText: "이메일 형식에 맞게 작성해주세요."),
            TextField(label: "비밀번호", placeHolder: "********", helpText: "대소문자, 숫자포함 8글자 이상 작성해주세요."),
            TextField(label: "비밀번호 확인", placeHolder: "********", helpText: "비밀번호를 다시 한번 입력해주세요.")
        ]),
        SignUpCategory(name: "회원 정보", textField: [
            TextField(label: "이름", placeHolder: "홍길동", helpText: "자신의 이름을 작성해주세요."),
            TextField(label: "전화번호", placeHolder: "01012345678", helpText: "'-'없이 입력해주세요")
        ])
    ]
    
    private let rightCompleteItem = UIBarButtonItem(title: "가입하기", style: .plain, target: self, action: #selector(buttonPressed))
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .systemBackground
        $0.register(SignUpCell.self, forCellReuseIdentifier: SignUpCell.identifier)
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 60
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigation()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setUpNavigation() {
        self.navigationItem.title = "회원가입"
        self.navigationController?.navigationBar.topItem?.title = "로그인"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        
        tabBarController?.tabBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        tabBarController?.tabBar.tintColor = UIColor.white
        
        self.navigationItem.setRightBarButton(rightCompleteItem, animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func createUI() {
        self.view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(588)
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    static private var instance: SignUpVC? = nil
    
    static func getInstance() -> SignUpVC {
        if(instance == nil) {
            instance = SignUpVC()
        }
        return instance!
    }
}

extension SignUpVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return signUpCategory.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signUpCategory[section].textField.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SignUpCell.identifier, for: indexPath) as! SignUpCell
        cell.selectionStyle = .none
        cell.boardTextField.label.text = signUpCategory[indexPath.section].textField[indexPath.row].label
        cell.boardTextField.placeholder = signUpCategory[indexPath.section].textField[indexPath.row].placeHolder
        cell.boardTextField.leadingAssistiveLabel.text = signUpCategory[indexPath.section].textField[indexPath.row].helpText
        
        if signUpCategory[indexPath.section].textField[indexPath.row].label == "이메일" {
            cell.boardTextField.keyboardType = .emailAddress
        } else if signUpCategory[indexPath.section].textField[indexPath.row].label == "비밀번호" {
            cell.boardTextField.keyboardType = .default
            cell.boardTextField.isSecureTextEntry = true
            cell.boardTextField.textContentType = .password
        } else if signUpCategory[indexPath.section].textField[indexPath.row].label == "비밀번호 확인" {
            cell.boardTextField.keyboardType = .default
            cell.boardTextField.isSecureTextEntry = true
            cell.boardTextField.textContentType = .password
        } else if signUpCategory[indexPath.section].textField[indexPath.row].label == "이름" {
            cell.boardTextField.keyboardType = .default
        } else if signUpCategory[indexPath.section].textField[indexPath.row].label == "전화번호" {
            cell.boardTextField.keyboardType = .numberPad
        }
        
        cell.boardTextField.tag = indexPath.row
        cell.boardTextField.delegate = self
        cell.boardTextField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = .systemBackground
        let label = UILabel().then {
            $0.font = .boldSystemFont(ofSize: 24)
            $0.text = signUpCategory[section].name
        }
        headerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.equalTo(headerView.snp.left).offset(20)
            make.centerY.equalTo(headerView)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20))
        let lineView = UIView()
        
        footerView.addSubview(lineView)
        footerView.backgroundColor = .systemBackground
        lineView.backgroundColor = .systemGray
        
        lineView.snp.makeConstraints { make in
            make.left.right.equalTo(footerView).inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            make.height.equalTo(1)
            make.centerY.equalTo(footerView)
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}

extension SignUpVC : UITextFieldDelegate {
    
    @objc func buttonPressed(sender: UIBarButtonItem!) {
        var checkInput : Bool! = true
        var errorString : String! = "알 수 없는 오류"
        
        if let email : String = self.email {
            print(email)
        } else {
            checkInput = false
        }
        
        if let password : String = self.password {
            print(password)
        } else {
            checkInput = false
        }
        
        if let passwordCheck : String = self.passwordCheck {
            print(passwordCheck)
        } else {
            checkInput = false
        }
        
        if let name : String = self.name {
            print(name)
        } else {
            checkInput = false
        }
        
        if let phoneNum : String = self.phonenum {
            print(phoneNum)
        } else {
            checkInput = false
        }
        
        if checkInput == false {
            errorString = "모든 정보를 입력해주세요"
        }
        
        if checkInput {
            if self.passwordCheck != self.password {
                errorString = "비밀번호가 다릅니다."
            } else {
                if self.email!.isValidEmail {
                    if self.passwordCheck!.isValidPassword {
                        if self.phonenum!.isVaildPhoneNum {
                            let userInformation : UserInformation = {
                                UserInformation(email: self.email!, password: self.passwordCheck!.capitalized, name: self.name!, phoneNum: self.phonenum!)
                            }()
                            print(userInformation.password)
                            MolaApi.shared.uploadUserInformation(requestURL: signUpRequestURL, userInfo: userInformation) { res in
                                switch res.result{
                                case .success(let data):
                                    if let jsonString = String(data: data, encoding: .utf8){
                                        if let jsonDict: [String: Any] = UtilityManager.shared.jsonStringToDictionary(jsonString: jsonString){
                                            print(jsonDict)
                                            print(jsonDict["status"] ?? "오류")
                                            if let status : Int = jsonDict["status"] as? Int {
                                                if status >= 400{
                                                    checkInput = false
                                                    errorString = "네트워크 연결이 불안정합니다."
                                                }
                                            }
                                            
                                            if checkInput == false {
                                                DispatchQueue.main.async {
                                                    let alert: UIAlertController = UIAlertController(title: "오류", message: errorString!, preferredStyle: .alert)
                                                    let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
                                                    alert.addAction(action)
                                                    self.present(alert, animated: true)
                                                }
                                            } else {
                                                DispatchQueue.main.async {
                                                    let alert: UIAlertController = UIAlertController(title: "성공", message: "모두의 라벨링 회원이 되신것을 환영합니다!", preferredStyle: .alert)
                                                    let action: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: self.popView)
                                                    alert.addAction(action)
                                                    self.present(alert, animated: true, completion: nil)
                                                    return
                                                }
                                            }
                                        }
                                    }
                                case .failure(let err):
                                    print("err발생")
                                    print(err)
                                    checkInput = false
                                    errorString = "네트워크 오류 발생"
                                }
                            }
                        } else {
                            checkInput = false
                            errorString = "올바른 전화번호 형식이 아닙니다."
                        }
                    } else {
                        checkInput = false
                        errorString = "올바른 비밀번호 형식이 아닙니다."
                    }
                } else {
                    checkInput = false
                    errorString = "올바른 이메일 형식이 아닙니다."
                }
            }
        }
        if checkInput == false {
            let alert: UIAlertController = UIAlertController(title: "오류", message: errorString!, preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc
    private func popView(_ sender: UIAlertAction) {
       self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func valueChanged(_ textField: MDCOutlinedTextField) {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        if textField.label.text == "이메일" {
            self.email = textField.text
        } else if textField.label.text == "비밀번호" {
            self.password = textField.text
        } else if textField.label.text == "비밀번호 확인" {
            self.passwordCheck = textField.text
        } else if textField.label.text == "이름" {
            self.name = textField.text
        } else if textField.label.text == "전화번호" {
            self.phonenum = textField.text
        }
    }
}

