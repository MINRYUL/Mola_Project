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
        view.backgroundColor = .white
        self.setupLabelTap()
        self.setupMainLayoutWithSnapKit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        print("labelTapped")
    }
    
    private func setupLabelTap() {
        let SignUpLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        self.signUpLabel.isUserInteractionEnabled = true
        self.signUpLabel.addGestureRecognizer(SignUpLabelTap)
    }
    
    private func setupMainLayoutWithSnapKit() {
        view.addSubview(titleimage)
        view.addSubview(idField)
        view.addSubview(pwField)
        view.addSubview(loginButton)
        view.addSubview(signUpLabel)
        
        titleimage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
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
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(3)
            make.leading.equalTo(loginButton.snp.leading).offset(230)
            make.trailing.equalTo(loginButton.snp.trailing).offset(0)
            make.height.equalTo(44)
        }
    }
}

extension String {
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    
    var isValidPassword: Bool {
        let passwordFormat = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
}
