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
    
//    struct Category {
//        let name: String
//        let textField: String
//    }
    
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
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .systemBackground
        $0.register(SignUpCell.self, forCellReuseIdentifier: SignUpCell.identifier)
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 60
    }
    
    private var signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemTeal
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.topItem?.title = "로그인"
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
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
    
    private func createUI() {
        self.navigationItem.title = "회원가입"
        view.addSubview(tableView)
        view.addSubview(signUpButton)
        
        tableView.snp.makeConstraints { maker in
//            maker.edges.equalTo(view)
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(588)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(5)
            make.leading.equalTo(tableView.snp.leading).offset(20)
            make.trailing.equalTo(tableView.snp.trailing).offset(-20)
            make.height.equalTo(44)
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


