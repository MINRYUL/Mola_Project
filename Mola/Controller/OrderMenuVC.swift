//
//  OrderMenuVC.swift
//  Mola
//
//  Created by 김민창 on 2021/05/17.
//

import UIKit

class OrderMenuVC: UIViewController {
    
    let orderModelList: [MyOrder] = [
        MyOrder(name: "강아지 라벨링", detail: "강아지 전체가 보이도록 사진을 라벨링 해주세요", progression: 1200, entire: 5000)
    ]
    
    private let orderTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .systemBackground
        $0.register(MyOrderCell.self, forCellReuseIdentifier: MyOrderCell.identifier)
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 60
    }
    
    private let requestLabel = UILabel().then() {
        $0.backgroundColor = .systemTeal
        $0.text = "         외주 등록                                                           >"
        $0.textColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpNavigation()
        createUI()
    }
    
    private func setUpNavigation() {
        self.navigationItem.title = "외주 메뉴"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
    }
    
    @objc func orderLabelTapped(_ sender: UITapGestureRecognizer) {
        print("labelTapped")
        let orderVC = OrderVC()
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    private func setupLabelTap() {
        let orderLabelTab = UITapGestureRecognizer(target: self, action: #selector(self.orderLabelTapped(_:)))
        self.requestLabel.isUserInteractionEnabled = true
        self.requestLabel.addGestureRecognizer(orderLabelTab)
    }
    
    private func createUI() {
        self.view.backgroundColor = .white
        orderTableView.dataSource = self
        orderTableView.delegate = self
        view.addSubview(orderTableView)
        view.addSubview(requestLabel)
        setupLabelTap()
        
        requestLabel.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-83)
            make.trailing.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.height.equalTo(65)
        }
        
        orderTableView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(view)
            make.bottom.equalTo(requestLabel.safeAreaLayoutGuide.snp.top).offset(0)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
            
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

extension OrderMenuVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyOrderCell.identifier, for: indexPath) as! MyOrderCell
        cell.selectionStyle = .none
        
        let progressValue : Float = Float((orderModelList[indexPath.row].progression / orderModelList[indexPath.row].entire) * 100)
        let progress = Progress(totalUnitCount: 100)
        progress.completedUnitCount = 0
        
        cell.labelNameLabel.text = orderModelList[indexPath.row].name
        cell.progressLabel.text = "\(progressValue) %"
        cell.progressBar.progress = 0.0
        
        progress.completedUnitCount = Int64(progressValue)
        cell.progressBar.setProgress(Float(progress.fractionCompleted), animated: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = .systemBackground
        let label = UILabel().then {
            $0.font = .boldSystemFont(ofSize: 24)
            $0.text = "나의 외주 목록"
        }
        headerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.equalTo(headerView.snp.left).offset(20)
            make.centerY.equalTo(headerView)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 5))
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
