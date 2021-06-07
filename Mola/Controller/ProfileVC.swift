//
//  myPageVC.swift
//  Pods
//
//  Created by 김민창 on 2021/05/11.
//

import UIKit

class ProfileVC: UIViewController {
    
    let requestPointRecordURL = "http://13.209.232.235:8080/user/searchPointHistory/"
    var pointModel: PointModel?
    
    private let pointHistoryTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .systemGray5
        $0.register(PointHistoryCell.self, forCellReuseIdentifier: PointHistoryCell.identifier)
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.isScrollEnabled = true
    }
    
    private let scrollView = UIScrollView().then() {
        $0.backgroundColor = .systemGray5
        $0.isScrollEnabled = false
        $0.sizeToFit()
    }
    
    private let contentView = UIView().then() {
        $0.backgroundColor = .systemGray5
    }
    
    private let subView = UIView().then() {
        $0.backgroundColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        $0.layer.cornerRadius = 26
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    private var userNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
        $0.text = "님의 포인트"
    }
    
    private var userPointLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32)
        $0.textColor = .white
        $0.text = "0"
    }
    
    private let chargeButton = UIButton().then {
        $0.layer.cornerRadius = 14
        $0.setTitle("충전하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
    }
    
    private let refundButton = UIButton().then {
        $0.layer.cornerRadius = 14
        $0.setTitle("환급받기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
    }
    
    private let buttonLineView = UIView().then {
        $0.backgroundColor = .darkGray
    }
    
    @objc func chargeButtonAction(sender: UIButton!) {
        let chargeVC = ChargeVC.getInstance()
        self.navigationController?.pushViewController(chargeVC, animated: true)
    }
    
    @objc func refundButtonAction(sender: UIButton!) {
        let refundVC = RefundVC.getInstance()
        self.navigationController?.pushViewController(refundVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpNavigation()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.viewWillAppear(true)
        let point = UserDefaults.standard.value(forKey: "UserPoint") as! Int
        userPointLabel.text = "\(point)"
        didReceivePointRecord()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func didReceivePointRecord() {
        let id = UserDefaults.standard.value(forKey: "UserId") as! Int
        let resultURL = "\(requestPointRecordURL)\(id)/"
        MolaApi.shared.changeUserPoint(requestURL: resultURL) { res in
            switch res.result{
            case .success(let data):
                if let jsonString = String(data: data, encoding: .utf8){
                    if let jsonDict: [String: Any] =
                        UtilityManager.shared.jsonStringToDictionary(jsonString: jsonString){
                        print(jsonDict)
                        if let status : Int = jsonDict["status"] as? Int {
                            if status >= 300 {
                                print("err")
                            } else {
                                do {
                                    let pointModel: PointModel = try JSONDecoder().decode(PointModel.self, from: data)
                                    self.pointModel = pointModel
                                    self.pointModel?.pointRecord = pointModel.pointRecord.reversed()
                                    
                                    DispatchQueue.main.async {
                                        self.pointHistoryTableView.reloadData()
                                    }
                                } catch(let err) {
                                    print(err.localizedDescription)
                                }
                            }
                        } else {
                            print("err")
                        }
                    }
                }
            case .failure(let err):
                print("err")
                print(err)
            }
        }
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
        let point = UserDefaults.standard.value(forKey: "UserPoint") as! Int
        let name = UserDefaults.standard.value(forKey: "UserName") as! String
        
        scrollView.delegate = self
        pointHistoryTableView.dataSource = self
        pointHistoryTableView.delegate = self
        view.backgroundColor = .systemGray6
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(subView)
        subView.addSubview(userNameLabel)
        subView.addSubview(userPointLabel)
        subView.addSubview(chargeButton)
        subView.addSubview(refundButton)
        subView.addSubview(buttonLineView)
        contentView.addSubview(pointHistoryTableView)
        
        scrollView.snp.makeConstraints{ make in
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
            make.height.equalTo(view.frame.width/2 - 30)
        }
        
        userPointLabel.snp.makeConstraints { make in
            userPointLabel.text = "\(point)"
            make.centerY.centerX.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints { make in
            userNameLabel.text = name + "님의 포인트"
            make.bottom.equalTo(userPointLabel.safeAreaLayoutGuide.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        chargeButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(view.frame.width/2 - 35)
            make.height.equalTo(50)
            chargeButton.addTarget(self, action: #selector(chargeButtonAction), for: .touchUpInside)
        }
        
        buttonLineView.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(1)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            refundButton.addTarget(self, action: #selector(refundButtonAction), for: .touchUpInside)
        }
        
        refundButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(chargeButton.safeAreaLayoutGuide.snp.trailing).offset(5)
            make.width.equalTo(view.frame.width/2 - 35)
            make.height.equalTo(50)
        }
        
        pointHistoryTableView.snp.makeConstraints{ make in
            make.top.equalTo(subView.safeAreaLayoutGuide.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(scrollView.safeAreaLayoutGuide.snp.bottom)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pointModel?.pointRecord.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PointHistoryCell.identifier, for: indexPath) as! PointHistoryCell
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
        let changeValue = (pointModel?.pointRecord[indexPath.row].pointAfter)! - (pointModel?.pointRecord[indexPath.row].pointBefore)!
        
        if changeValue >= 100 {
            cell.pointName.textColor = .systemBlue
            cell.typeView.backgroundColor = .systemBlue
            cell.updatePoint.text = "+ " + (String)(changeValue)
            cell.pointName.text = "충전"
            cell.updatePoint.textColor = .systemBlue
        } else if changeValue < 0 {
            cell.pointName.textColor = .systemRed
            cell.typeView.backgroundColor = .systemRed
            cell.updatePoint.text =  (String)(changeValue)
            cell.pointName.text = "차감"
            cell.updatePoint.textColor = .systemRed
        } else {
            cell.pointName.textColor = .black
            cell.typeView.backgroundColor = .darkGray
            cell.updatePoint.text = "+ " + (String)(changeValue)
            cell.pointName.text = "휙득"
            cell.updatePoint.textColor = .black
        }
        
        cell.pointDate.text = pointModel?.pointRecord[indexPath.row].pointChangeDate
        cell.updateDetail.text = "\((pointModel?.pointRecord[indexPath.row].pointAfter)!) P"
            
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60)).then() {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 26
            $0.layer.maskedCorners = [.layerMaxXMinYCorner,]
        }
        
        let label = UILabel().then {
            $0.font = .boldSystemFont(ofSize: 23)
            $0.textColor = .systemBlue
            $0.text = "내역확인"
        }
        
        headerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.top).offset(10)
            make.left.equalTo(headerView.snp.left).offset(10)
            make.centerY.equalTo(headerView)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20)).then(){
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20
            $0.layer.maskedCorners = [.layerMaxXMaxYCorner]
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}
