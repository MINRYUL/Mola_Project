//
//  mainVC.swift
//  Mola
//
//  Created by 김민창 on 2021/04/29.
//

import UIKit
import MaterialComponents.MaterialNavigationDrawer
import SideMenu

class MainVC: UIViewController, MDCBottomDrawerViewControllerDelegate, UIScrollViewDelegate {
    
    @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    private var sideMenuControllr: SideMenuNavigationController?
    
    let headerViewController = DrawerHeaderViewController()
    let contentViewController = DrawerContentViewController()

    private var leftMenuItem = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "text.justify")
        $0.action = #selector(navigationButton)
    }
    
    private var topSubView = UIView().then {
        $0.backgroundColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
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
    
    private var mainScrollView = UIScrollView().then() {
        $0.backgroundColor = .systemBackground
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.bounces = true
        
    }
    
    private var mainContentView = UIView().then() {
        $0.backgroundColor = .systemBackground
    }
    
    let requestView = UIView()
    let ordersView = UIView()
    
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
        view.backgroundColor = colorScheme.backgroundColor
        self.mainScrollView.delegate = self
        
        let xOffset = view.frame.size.width
        let yOffset = view.frame.size.height - 300
        
        mainScrollView.contentSize = CGSize(width: Int(xOffset) * 2, height: Int(yOffset))
        
        view.addSubview(topSubView)
        view.addSubview(mainScrollView)
        topSubView.addSubview(userNameLabel)
        topSubView.addSubview(userPointLabel)
        topSubView.addSubview(pointButtonImage)
//        mainScrollView.addSubview(mainContentView)
        
        
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
        
        mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(topSubView.safeAreaLayoutGuide.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        _ = [requestView, ordersView].map { self.mainScrollView.addSubview($0) }
        
        requestView.backgroundColor = .systemTeal
        ordersView.backgroundColor = .systemBlue
        
        requestView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(yOffset)
            make.left.equalToSuperview()
        }

        ordersView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(yOffset)
            make.left.equalToSuperview().offset(xOffset)
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
