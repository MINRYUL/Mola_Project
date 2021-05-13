//
//  SignUpViewController.swift
//  Mola
//
//  Created by 김민창 on 2021/04/18.
//

import UIKit
import SnapKit
import Then

class SignUpVC: UIViewController {
    let signUpCategory: [SignUpCategory] = [
        SignUpCategory(name: "가입 정보", textField: [
            TextField(label: "이메일", placeHolder: "example@gmail.com", helpText: "이메일 형식에 맞게 작성해 주세요."),
            TextField(label: "비밀번호", placeHolder: "********", helpText: "대소문자 포함 8글자 이상 작성해 주세요."),
            TextField(label: "비밀번호 확인", placeHolder: "********", helpText: "비밀번호를 다시 한번 입력해 주세요.")
        ]),
        SignUpCategory(name: "회원 정보", textField: [
            TextField(label: "닉네임", placeHolder: "", helpText: "자신이 사용할 닉네임을 작성해 주세요."),
            TextField(label: "직업", placeHolder: "학생", helpText: "자신의 현재 직업을 작성해 주세요.")
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
    
    @objc func buttonPressed(sender: UIBarButtonItem!) {
        print("touch navigationButton button")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
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
        
        self.navigationItem.setRightBarButtonItems([rightCompleteItem], animated: true)
    }
    
    private func createUI() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
//            maker.edges.equalTo(view)
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


