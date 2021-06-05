//
//  mainVC.swift
//  Mola
//
//  Created by 김민창 on 2021/04/29.
//

import UIKit
import SideMenu

class MainVC: UIViewController {
    private var sideMenuControllr: SideMenuNavigationController?

    //MAKR: - Main UI
    private var leftMenuItem = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "text.justify")
        $0.action = #selector(navigationButton)
    }
    
    private var topSubView = UIView().then {
        $0.backgroundColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
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
    
    private var mainPointButton = UIButton().then() {
        $0.setImage(UIImage(systemName: "chevron.forward"),for: .normal)
        $0.sizeToFit()
        $0.tintColor = .white
    }
    
    //MAKR: - Scroll UI
    private var mainScrollView = UIScrollView().then() {
        $0.backgroundColor = .systemGray6
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.bounces = true
        $0.alwaysBounceVertical = false
    }
    
    private var pageControl = UIPageControl().then() {
        $0.hidesForSinglePage = true
        $0.numberOfPages = 3
        $0.pageIndicatorTintColor = .darkGray
    }
    
    private var requestView = UIView().then() {
        $0.backgroundColor = .systemGray6
    }
    
    private var ordersView = UIView().then() {
        $0.backgroundColor = .systemGray6
    }
    
    private var profileView = UIView().then() {
        $0.backgroundColor = .systemGray6
    }

    //MAKR: - Request UI
    private var requestInView = UIView().then() {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 135
    }
    
    private var requestLabel = UILabel().then() {
        $0.font = .systemFont(ofSize: 31)
        $0.text = "모든 라벨링 의뢰 \n시작하시겠습니까?"
        $0.textColor = .darkGray
        $0.numberOfLines = 2
    }
    
    private var requestButton = UIButton().then() {
        $0.layer.cornerRadius = 14
        $0.setTitle("외주시작", for: .normal)
        $0.backgroundColor = .systemTeal
    }
    
    private var requestImage = UIImageView().then() {
        $0.image = UIImage(named: "main_request")
        $0.contentMode = .scaleAspectFit
    }
    
    //MAKR: - Order UI
    private var orderInView = UIView().then() {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 135
    }
    
    private var orderLabel = UILabel().then() {
        $0.font = .systemFont(ofSize: 31)
        $0.text = "유저가 함께하는 의뢰 \n시작하시겠습니까?"
        $0.textColor = .darkGray
        $0.numberOfLines = 2
    }
    
    private var orderButton = UIButton().then() {
        $0.layer.cornerRadius = 14
        $0.setTitle("외주신청", for: .normal)
        $0.backgroundColor = .systemTeal
    }
    
    private var orderImage = UIImageView().then() {
        $0.image = UIImage(named: "main_order")
        $0.contentMode = .scaleAspectFit
    }
    
    //MARK: - Profile UI
    private var profileInView = UIView().then() {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 135
    }
    
    private var profileLabel = UILabel().then() {
        $0.font = .systemFont(ofSize: 31)
        $0.text = "획득한 포인트를 \n확인해보세요!"
        $0.textColor = .darkGray
        $0.numberOfLines = 2
    }
    
    private var profileButton = UIButton().then() {
        $0.layer.cornerRadius = 14
        $0.setTitle("내역확인", for: .normal)
        $0.backgroundColor = .systemTeal
    }
    
    private var profileImage = UIImageView().then() {
        $0.image = UIImage(named: "main_profile")
        $0.contentMode = .scaleAspectFit
    }
    
    @objc func navigationButton(sender: UIBarButtonItem!) {
        print("touch navigationButton button")
        let sidemenu = CustomSideMenuVC.getInstance()
        sidemenu.hostViewController = self
        self.sideMenuControllr = SideMenuNavigationController(rootViewController: sidemenu)
        self.sideMenuControllr!.leftSide = true
        self.sideMenuControllr!.isNavigationBarHidden = true
        self.sideMenuControllr!.settings.presentationStyle = .menuSlideIn
        self.sideMenuControllr!.settings.presentationStyle.presentingEndAlpha = 0.6
        self.sideMenuControllr!.settings.statusBarEndAlpha = 0
        CustomSideMenuVC.getInstance().createUI()
        present(self.sideMenuControllr!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigation()
        self.createUI()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "모두의 라벨링"
                
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        self.navigationItem.setLeftBarButtonItems([leftMenuItem], animated: true)
        
        tabBarController?.tabBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        tabBarController?.tabBar.tintColor = .white
        tabBarController?.tabBar.unselectedItemTintColor = .lightText
        
        leftMenuItem.target = self
    }
    
    private func createUI() {
        let point = UserDefaults.standard.value(forKey: "UserPoint") as! Int
        let name = UserDefaults.standard.value(forKey: "UserName") as! String
        userNameLabel.text = name + "님의 포인트"
        userPointLabel.text = "\(point)"
        
        
        view.backgroundColor = .white
        self.mainScrollView.delegate = self
        
        let xOffset = view.frame.size.width
        let yOffset = view.frame.size.height - 350
        
        mainScrollView.contentSize = CGSize(width: Int(xOffset) * 3, height: Int(yOffset))
        
        view.addSubview(topSubView)
        view.addSubview(mainScrollView)
        view.addSubview(pageControl)
        topSubView.addSubview(userNameLabel)
        topSubView.addSubview(userPointLabel)
        topSubView.addSubview(mainPointButton)
        
        _ = [requestView, ordersView, profileView].map { self.mainScrollView.addSubview($0) }
        
        topSubView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        
        pageControl.snp.makeConstraints{ make in
            make.top.equalTo(topSubView.safeAreaLayoutGuide.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
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
        
        mainPointButton.snp.makeConstraints { make in
            make.top.equalTo(userPointLabel).offset(9)
            make.leading.equalTo(userPointLabel).offset(20)
            make.trailing.equalTo(userPointLabel).offset(-5)
            mainPointButton.addTarget(self, action: #selector(profileButtonAction), for: .touchUpInside)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(topSubView.safeAreaLayoutGuide.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        requestView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(yOffset)
            make.left.equalToSuperview()
        }

        ordersView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(yOffset)
            make.left.equalToSuperview().offset(xOffset)
        }
        
        profileView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(yOffset)
            make.left.equalToSuperview().offset(xOffset * 2)
        }
        
        setUpRequestUI()
        setUpOrderUI()
        setUpProfileUI()
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

//MAKR: - Scroll init
extension MainVC{
    
    @objc func outsourcingButtonAction(sender: UIButton!) {
        print("touch login button")
        guard let outsourcingVC = tabBarController?.viewControllers?[1] else { return }
        tabBarController?.selectedViewController = outsourcingVC
    }
    
    private func setUpRequestUI() {
        requestView.addSubview(requestInView)
        requestView.addSubview(requestLabel)
        requestView.addSubview(requestButton)
        requestInView.addSubview(requestImage)
        
        requestLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-80)
        }
        
        requestButton.snp.makeConstraints{ make in
            make.top.equalTo(requestLabel.safeAreaLayoutGuide.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(80)
            make.width.equalTo(110)
            make.height.equalTo(45)
            requestButton.addTarget(self, action: #selector(outsourcingButtonAction), for: .touchUpInside)
        }
        
        requestInView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(170)
            make.leading.equalToSuperview().offset(65)
            make.trailing.equalToSuperview().offset(-65)
            make.bottom.equalToSuperview().offset(-90)
        }
        
        requestImage.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    @objc func orderButtonAction(sender: UIButton!) {
        print("touch login button")
        guard let orderMenuVC = tabBarController?.viewControllers?[2] else { return }
        tabBarController?.selectedViewController = orderMenuVC
    }
    
    private func setUpOrderUI() {
        ordersView.addSubview(orderInView)
        ordersView.addSubview(orderLabel)
        ordersView.addSubview(orderButton)
        orderInView.addSubview(orderImage)
        
        orderLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(80)
        }
        
        orderButton.snp.makeConstraints{ make in
            make.top.equalTo(orderLabel.safeAreaLayoutGuide.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(80)
            make.width.equalTo(110)
            make.height.equalTo(45)
            orderButton.addTarget(self, action: #selector(orderButtonAction), for: .touchUpInside)
        }
        
        orderInView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(170)
            make.leading.equalToSuperview().offset(65)
            make.trailing.equalToSuperview().offset(-65)
            make.bottom.equalToSuperview().offset(-90)
        }
        
        orderImage.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    @objc func profileButtonAction(sender: UIButton!) {
        print("touch login button")
        guard let profileVC = tabBarController?.viewControllers?[3] else { return }
        tabBarController?.selectedViewController = profileVC
    }
    
    private func setUpProfileUI() {
        profileView.addSubview(profileInView)
        profileView.addSubview(profileLabel)
        profileView.addSubview(profileButton)
        profileInView.addSubview(profileImage)
        
        profileLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(80)
        }
        
        profileButton.snp.makeConstraints{ make in
            make.top.equalTo(profileLabel.safeAreaLayoutGuide.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(80)
            make.width.equalTo(110)
            make.height.equalTo(45)
            profileButton.addTarget(self, action: #selector(profileButtonAction), for: .touchUpInside)
        }
        
        profileInView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(170)
            make.leading.equalToSuperview().offset(65)
            make.trailing.equalToSuperview().offset(-65)
            make.bottom.equalToSuperview().offset(-90)
        }
        
        profileImage.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(150)
        }
    }
}

//MAKR: - PageControl delegate
extension MainVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // floor 내림, ceil 올림
        // contentOffset는 현재 스크롤된 좌표
        pageControl.currentPage = Int(floor(mainScrollView.contentOffset.x / UIScreen.main.bounds.width))
    }
}
