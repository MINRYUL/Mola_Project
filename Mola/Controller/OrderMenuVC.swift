//
//  OrderMenuVC.swift
//  Mola
//
//  Created by 김민창 on 2021/05/17.
//

import UIKit

class OrderMenuVC: UIViewController {
    
    let cellSpacingHeight: CGFloat = 5
    let requestOutSourceListURL = "http://13.209.232.235:8080/outsource/searchUserOSList"
    var outSourceList: OutSourceList?
    
    private let outSourceTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .systemGray6
        $0.register(MyOrderCell.self, forCellReuseIdentifier: MyOrderCell.identifier)
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 60
    }
    
    private let requestLabel = UILabel().then() {
        $0.backgroundColor = .systemTeal
        $0.text = "         외주 등록                                                           >"
        $0.textColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpNavigation()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        didReceiveOutSoruces()
    }
    
    private func didReceiveOutSoruces() {
        let id: MyId = {
            MyId(id: UserDefaults.standard.value(forKey: "UserId") as! Int )
        }()
        
        MolaApi.shared.requestOutSourceList(requestURL: requestOutSourceListURL, id: id){
            res in
            switch res.result {
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
                                    let outSourceData: OutSourceList = try JSONDecoder().decode(OutSourceList.self, from: data)
                                    self.outSourceList = outSourceData
                                    DispatchQueue.main.async {
                                        self.outSourceTableView.reloadData()
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
                print("err발생")
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
    }
    
    @objc func orderLabelTapped(_ sender: UITapGestureRecognizer) {
        print("labelTapped")
        let orderVC = OrderVC.getInstance()
        orderVC.hostViewController = self
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    private func setupLabelTap() {
        let orderLabelTab = UITapGestureRecognizer(target: self, action: #selector(self.orderLabelTapped(_:)))
        self.requestLabel.isUserInteractionEnabled = true
        self.requestLabel.addGestureRecognizer(orderLabelTab)
    }
    
    private func createUI() {
        self.view.backgroundColor = .systemGray6
        outSourceTableView.dataSource = self
        outSourceTableView.delegate = self
        view.addSubview(outSourceTableView)
        view.addSubview(requestLabel)
        setupLabelTap()
        
        requestLabel.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-83)
            make.trailing.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.height.equalTo(65)
        }
        
        outSourceTableView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(view)
            make.bottom.equalTo(requestLabel.safeAreaLayoutGuide.snp.top)
            
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
        return outSourceList?.outSources.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyOrderCell.identifier, for: indexPath) as! MyOrderCell
        cell.selectionStyle = .none
        
        let progressValue : Float = Float(((outSourceList?.outSources[indexPath.row].imgCompleted ?? 0) / (outSourceList?.outSources[indexPath.row].imgTotal ?? 1)) * 100)
        let progress = Progress(totalUnitCount: 100)
        progress.completedUnitCount = 0
        
        cell.labelNameLabel.text = outSourceList?.outSources[indexPath.row].title ?? " "
        cell.progressLabel.text = "\(progressValue) %"
        cell.progressBar.progress = 0.0
        
        progress.completedUnitCount = Int64(progressValue)
        cell.progressBar.setProgress(Float(progress.fractionCompleted), animated: true)
        
        cell.backgroundColor = .systemGray6
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("detail order seleted")
        let selectedOrder = outSourceList?.outSources[indexPath.row]
        let detailOrderVC = DetailOrderVC()
        
        detailOrderVC.outSourceModel = selectedOrder
        navigationController?.pushViewController(detailOrderVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = 8
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        let label = UILabel().then {
            $0.font = .boldSystemFont(ofSize: 24)
            $0.textColor = .white
            $0.text = "나의 외주 목록"
        }
        
        headerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.equalTo(headerView.snp.left).offset(20)
            make.centerY.equalTo(headerView)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}


