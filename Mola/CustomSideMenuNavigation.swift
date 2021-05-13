//
//  CustomSideMenuNavigation.swift
//  
//
//  Created by 김민창 on 2021/05/13.
//

import UIKit
import SideMenu

class CustomSideMenuNavigation: UIViewController {
    
    var hostViewController: UIViewController? = nil
    
    private let stackView = UIStackView().then() {
        $0.axis = .vertical
        $0.spacing = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 50/225, green: 150/255, blue: 210/255, alpha:1.0)
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }

    private let homeLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 21)
        $0.textColor = .white
        $0.text = "홈"
    }

    private let orderLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 21)
        $0.textColor = .white
        $0.text = "외주하기"
    }

    private let jobLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 21)
        $0.textColor = .white
        $0.text = "외주받기"
    }

    private let profileLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 21)
        $0.textColor = .white
        $0.text = "프로필"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    func createUI() {
        self.view.backgroundColor = UIColor(red: 50/225, green: 150/255, blue: 210/255, alpha:1.0)
        view.addSubview(stackView)
        self.stackView.addArrangedSubview(homeLabel)
        self.stackView.addArrangedSubview(orderLabel)
        self.stackView.addArrangedSubview(jobLabel)
        self.stackView.addArrangedSubview(profileLabel)
        
        stackView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    static private var instance:CustomSideMenuNavigation? = nil
    
    static func getInstance() -> CustomSideMenuNavigation {
        if(instance == nil) {
            instance = CustomSideMenuNavigation()
        }
        return instance!
    }
}
