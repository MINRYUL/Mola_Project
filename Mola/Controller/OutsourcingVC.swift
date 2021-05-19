//
//  OutsourcingVC.swift
//  Mola
//
//  Created by 김민창 on 2021/05/19.
//

import UIKit

class OutsourcingVC: UIViewController {
    
    private let leftRefrashItem = UIBarButtonItem(title: "새로고침", style: .plain, target: self, action: #selector(leftButtonPressed))
    
    private let rightNextItem = UIBarButtonItem(title: "다음사진", style: .plain, target: self, action: #selector(rightButtonPressed))
    
    private let detailImage = UIImageView().then() {
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    private let explainLabel = UILabel().then() {
        $0.text = "이미지를 탭하여 라벨링 작업을 수행할 수 있습니다."
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 11)
    }
    
    private let creditabel = UILabel().then() {
        $0.text = "+5 Point"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let subView = UIView().then() {
        $0.backgroundColor = .systemGray5
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let orderNameLabel = UILabel().then() {
        $0.text = "꽃 라벨링"
        $0.font = .boldSystemFont(ofSize: 21)
        $0.textColor = .black
    }
    
    private let requirementsLabel = UILabel().then() {
        $0.text = "꽃잎 전체가 보이도록 타이트하게 라벨링 해주세요."
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .darkGray
    }
    
    
    @objc func leftButtonPressed(sender: UIBarButtonItem!) {
        print("touch left navigationButton button")
    }
    
    @objc func rightButtonPressed(sender: UIBarButtonItem!) {
        print("touch right navigationButton button")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = .black
        setupNavigation()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.barTintColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "일 하기"
        
        self.navigationItem.setLeftBarButtonItems([leftRefrashItem], animated: true)
        self.navigationItem.setRightBarButtonItems([rightNextItem], animated: true)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .black
    }
    
    private func createUI() {
        view.backgroundColor = .systemGray2
        view.addSubview(detailImage)
        view.addSubview(explainLabel)
        view.addSubview(creditabel)
        view.addSubview(subView)
        subView.addSubview(orderNameLabel)
        subView.addSubview(requirementsLabel)
        
        detailImage.snp.makeConstraints{ make in
            make.centerX.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.width)
        }
        
        creditabel.snp.makeConstraints{ make in
            make.top.equalTo(detailImage.safeAreaLayoutGuide.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(15)
        }
        
        explainLabel.snp.makeConstraints{ make in
            make.top.equalTo(detailImage.safeAreaLayoutGuide.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        subView.snp.makeConstraints{ make in
            make.top.equalTo(creditabel.safeAreaLayoutGuide.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        orderNameLabel.snp.makeConstraints{ make in
            make.top.leading.equalToSuperview().offset(20)
        }
        
        requirementsLabel.snp.makeConstraints{ make in
            make.top.equalTo(orderNameLabel.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
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
