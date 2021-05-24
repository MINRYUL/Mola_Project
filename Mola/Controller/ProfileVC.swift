//
//  myPageVC.swift
//  Pods
//
//  Created by 김민창 on 2021/05/11.
//

import UIKit

class ProfileVC: UIViewController {
    
    let point: [PointModel] = [
        PointModel(name: "포인트 내역", pointHistory:
                [PointHistory(type: "휙득", beforeChange: 5000, afterChange: 5005, date: "5/22 5:10"),
                PointHistory(type: "차감", beforeChange: 15000, afterChange: 5000, date: "5/22 5:07"),
                PointHistory(type: "충전", beforeChange: 10000, afterChange: 15000, date: "5/22 5:05"),
                 PointHistory(type: "충전", beforeChange: 0, afterChange: 10000, date: "5/22 5:03"
                )])
    ]
    
    private let pointHistoryTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .systemGray6
        $0.register(PointHistoryCell.self, forCellReuseIdentifier: PointHistoryCell.identifier)
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
    }
    
    private let scrollView = UIScrollView().then() {
        $0.backgroundColor = .systemGray6
        $0.isScrollEnabled = true
        $0.sizeToFit()
    }
    
    private let contentView = UIView().then() {
        $0.backgroundColor = .systemGray6
    }
    
    private let subView = UIView().then() {
        $0.backgroundColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
    }
    
    private let creditBackgroundView = UIView().then() {
        $0.backgroundColor = .systemBlue
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let creditView = UIView().then() {
        $0.backgroundColor = .lightText
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private var userNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
        $0.text = "김민창님의 포인트"
    }
    
    private var userPointLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32)
        $0.textColor = .white
        $0.text = "330,312"
    }
    
    private let chargeButton = UIButton().then {
        $0.layer.cornerRadius = 14
        $0.setTitle("충전하기", for: .normal)
        $0.backgroundColor = .systemTeal
    }
    
    private let refundButton = UIButton().then {
        $0.layer.cornerRadius = 14
        $0.setTitle("환급받기", for: .normal)
        $0.backgroundColor = .systemBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpNavigation()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func setUpNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        
        tabBarController?.tabBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        tabBarController?.tabBar.tintColor = .white
        tabBarController?.tabBar.unselectedItemTintColor = .lightText
    }
    
    private func createUI() {
        pointHistoryTableView.dataSource = self
        pointHistoryTableView.delegate = self
        view.backgroundColor = .systemGray6
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(subView)
        contentView.addSubview(creditBackgroundView)
        contentView.addSubview(creditView)
        creditView.addSubview(userNameLabel)
        creditView.addSubview(userPointLabel)
        contentView.addSubview(chargeButton)
        contentView.addSubview(refundButton)
        contentView.addSubview(pointHistoryTableView)
        
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints{ make in
            make.height.equalToSuperview()
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }
        
        subView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.width/2 - 90)
        }
        
        creditBackgroundView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(view.frame.width/4 - 80)
            make.bottom.equalTo(subView.safeAreaLayoutGuide.snp.bottom).offset(view.frame.width/4)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        creditView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(view.frame.width/4 - 78)
            make.bottom.equalTo(subView.safeAreaLayoutGuide.snp.bottom).offset(view.frame.width/4)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(creditView.safeAreaLayoutGuide.snp.top).offset(68)
            make.leading.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        userPointLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel).offset(20)
            make.leading.equalTo(userNameLabel)
            make.trailing.equalTo(userNameLabel)
        }
        
        chargeButton.snp.makeConstraints{ make in
            make.top.equalTo(creditView.safeAreaLayoutGuide.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(view.frame.width/2 - 35)
            make.height.equalTo(50)
        }
        
        refundButton.snp.makeConstraints{ make in
            make.top.equalTo(creditView.safeAreaLayoutGuide.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalTo(chargeButton.safeAreaLayoutGuide.snp.trailing).offset(5)
            make.width.equalTo(view.frame.width/2 - 35)
            make.height.equalTo(50)
        }
        
        pointHistoryTableView.snp.makeConstraints{ make in
            make.top.equalTo(chargeButton.safeAreaLayoutGuide.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
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

extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return point.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return point[section].pointHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PointHistoryCell.identifier, for: indexPath) as! PointHistoryCell
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
        if point[indexPath.section].pointHistory[indexPath.row].type == "충전" {
            cell.pointName.textColor = .systemBlue
            cell.typeView.backgroundColor = .systemBlue
            cell.updatePoint.text = "+ " + (String)(point[indexPath.section].pointHistory[indexPath.row].afterChange - point[indexPath.section].pointHistory[indexPath.row].beforeChange)
            cell.updatePoint.textColor = .systemBlue
        } else if point[indexPath.section].pointHistory[indexPath.row].type == "차감"{
            cell.pointName.textColor = .systemRed
            cell.typeView.backgroundColor = .systemRed
            cell.updatePoint.text =  (String)(point[indexPath.section].pointHistory[indexPath.row].afterChange - point[indexPath.section].pointHistory[indexPath.row].beforeChange)
            cell.updatePoint.textColor = .systemRed
        } else {
            cell.pointName.textColor = .black
            cell.typeView.backgroundColor = .darkGray
            cell.updatePoint.text = "+ " + (String)(point[indexPath.section].pointHistory[indexPath.row].afterChange - point[indexPath.section].pointHistory[indexPath.row].beforeChange)
            cell.updatePoint.textColor = .black
        }
        cell.pointDate.text = point[indexPath.section].pointHistory[indexPath.row].date
        cell.pointName.text = point[indexPath.section].pointHistory[indexPath.row].type
        cell.updateDetail.text = (String)(point[indexPath.section].pointHistory[indexPath.row].afterChange)
            
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60)).then() {
            $0.backgroundColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
            $0.layer.cornerRadius = 12
            $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        
        let label = UILabel().then {
            $0.font = .boldSystemFont(ofSize: 24)
            $0.textColor = .white
            $0.text = "나의 포인트 내역"
        }
        
//        let lineView = UIView().then {
//            $0.backgroundColor = .darkGray
//        }
        
        headerView.addSubview(label)
//        headerView.addSubview(lineView)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.top).offset(10)
            make.left.equalTo(headerView.snp.left).offset(10)
            make.centerY.equalTo(headerView)
        }
        
//        lineView.snp.makeConstraints { make in
//            make.top.equalTo(label.safeAreaLayoutGuide.snp.bottom).offset(10)
//            make.left.right.equalTo(headerView).inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
//            make.height.equalTo(1)
//        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}
