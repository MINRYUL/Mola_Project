//
//  mainVC.swift
//  Mola
//
//  Created by 김민창 on 2021/04/29.
//

import UIKit
import MaterialComponents.MaterialNavigationDrawer

class MainVC: UIViewController, MDCBottomDrawerViewControllerDelegate {
    
    @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    
    let headerViewController = DrawerHeaderViewController()
    let contentViewController = DrawerContentViewController()

    let orderList: [OrderList] = [
        OrderList(name: "관심있는 의뢰", order: [
            Order(name: "사람 얼굴 라벨링", detail: "사람 얼굴 전체가 보이도록 라벨링 해주세요"),
            Order(name: "의자 라벨링", detail: "의자 전체가 보이도록 라벨링 해주세요"),
            Order(name: "컴퓨터 라벨링", detail: "모니터와 본체 모두 보이도록 라벨링 해주세요")
        ]),
        OrderList(name: "의뢰 리스트", order: [
            Order(name: "신호등 라벨링", detail: "신호등을 중점으로 라벨링 해주세요"),
            Order(name: "자동차 라벨링", detail: "자동차 앞면을 중심으로 라벨링 해주세요"),
            Order(name: "강아지 라벨링", detail: "강아지 전체 모습이 보이도록 라벨링 해주세요"),
            Order(name: "나무 라벨링", detail: "나무 전체 모습이 보이도록 라벨링 해주세요"),
            Order(name: "집 라벨링", detail: "집의 전체 모습이 보이도록 라벨링 해주세요")
        ])
    ]
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .systemBackground
        $0.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 60
    }
    
    private var leftMenuItem = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "text.justify")
        $0.action = #selector(navigationButton)
    }
    
    private var topSubView = UIView().then {
        $0.backgroundColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
//        $0.backgroundColor = .systemTeal
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
    
    private var pointButtonImage = UIImageView().then(){
        $0.image = UIImage(systemName: "chevron.forward")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    private var orderButton = UIButton().then(){
        $0.setTitle("외주 등록", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemTeal
        $0.layer.cornerRadius = 10
    }
    
    @objc func navigationButton(sender: UIBarButtonItem!) {
        print("touch navigationButton button")
        let bottomDrawerViewController = MDCBottomDrawerViewController()
        bottomDrawerViewController.setTopCornersRadius(24, for: .collapsed)
        bottomDrawerViewController.setTopCornersRadius(8, for: .expanded)
        bottomDrawerViewController.isTopHandleHidden = false
        bottomDrawerViewController.topHandleColor = UIColor.lightGray
        bottomDrawerViewController.contentViewController = contentViewController
        bottomDrawerViewController.headerViewController = headerViewController
        bottomDrawerViewController.delegate = self
        bottomDrawerViewController.headerViewController?.view.backgroundColor = colorScheme.surfaceColor;
        bottomDrawerViewController.contentViewController?.view.backgroundColor = colorScheme.surfaceColor;
        bottomDrawerViewController.scrimColor = colorScheme.onSurfaceColor.withAlphaComponent(0.32)
        present(bottomDrawerViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorScheme.backgroundColor
        // Do any additional setup after loading the view.
        self.setupNavigation()
        self.createUI()

    }
    
    private func setupNavigation() {
        self.navigationItem.title = "모두의 라벨링"
        
        UINavigationBar.appearance().isTranslucent = false
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
//        self.navigationController?.navigationBar.barTintColor = .systemTeal
        self.navigationItem.setLeftBarButtonItems([leftMenuItem], animated: true)
        
        tableView.dataSource = self
        tableView.delegate = self
        leftMenuItem.target = self
    }
    
    private func createUI() {
        view.addSubview(topSubView)
        view.addSubview(orderButton)
        view.addSubview(tableView)
        topSubView.addSubview(userNameLabel)
        topSubView.addSubview(userPointLabel)
        topSubView.addSubview(pointButtonImage)
        
        topSubView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(58)
            make.leading.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        userPointLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel).offset(20)
            make.leading.equalTo(userNameLabel)
            make.trailing.equalTo(userNameLabel)
        }
        
        pointButtonImage.snp.makeConstraints { make in
            make.top.equalTo(userPointLabel).offset(9)
            make.leading.equalTo(userPointLabel).offset(20)
            make.trailing.equalTo(userPointLabel).offset(-5)
        }
        
        orderButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(255)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(orderButton.safeAreaLayoutGuide.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    func bottomDrawerControllerDidChangeTopInset(_ controller: MDCBottomDrawerViewController,
                                                 topInset: CGFloat) {
        headerViewController.titleLabel.center =
            CGPoint(x: headerViewController.view.frame.size.width / 2,
                    y: (headerViewController.view.frame.size.height + topInset) / 2)
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

extension MainVC: UITableViewDataSource, UITableViewDelegate {
//  @objc class func catalogMetadata() -> [String: Any] {
//    return [
//      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer"],
//      "primaryDemo": false,
//      "presentable": false,
//    ]
//  }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList[section].order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        cell.selectionStyle = .none
        
        cell.nameText.text = orderList[indexPath.section].order[indexPath.row].name
        cell.detailText.text = orderList[indexPath.section].order[indexPath.row].detail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = .systemBackground
        let label = UILabel().then {
            $0.font = .boldSystemFont(ofSize: 24)
            $0.text = orderList[section].name
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
