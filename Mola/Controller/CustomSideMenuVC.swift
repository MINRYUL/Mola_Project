//
//  CustomSideMenuNavigation.swift
//
//
//  Created by 김민창 on 2021/05/13.
//

import UIKit
import SideMenu

class CustomSideMenuVC: UIViewController {
    
    var hostViewController: UIViewController? = nil
        
    private let molaLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textColor = .white
        $0.text = "MOLA"
    }
    
    private let stackView = UIStackView().then() {
        $0.axis = .vertical
        $0.spacing = 23
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 50/225, green: 150/255, blue: 210/255, alpha:1.0)
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }

    private let homeLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.text = "홈"
    }

    private let orderLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.text = "외주등록"
    }

    private let jobLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.text = "외주받기"
    }

    private let profileLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.text = "프로필"
    }
    
    private let logoutLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.text = "로그아웃"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    func createUI() {
        self.view.backgroundColor = UIColor(red: 50/225, green: 150/255, blue: 210/255, alpha:1.0)
        view.addSubview(stackView)
        view.addSubview(molaLabel)
        self.stackView.addArrangedSubview(homeLabel)
        self.stackView.addArrangedSubview(orderLabel)
        self.stackView.addArrangedSubview(jobLabel)
        self.stackView.addArrangedSubview(profileLabel)
        self.stackView.addArrangedSubview(logoutLabel)
        
        molaLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{ make in
            make.top.equalTo(molaLabel.safeAreaLayoutGuide.snp.bottom).offset(35)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    static private var instance:CustomSideMenuVC? = nil
    
    static func getInstance() -> CustomSideMenuVC {
        if(instance == nil) {
            instance = CustomSideMenuVC()
        }
        return instance!
    }
}
