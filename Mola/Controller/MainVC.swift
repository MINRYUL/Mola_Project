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
        self.setupMainLayoutWithSnapKit()

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
        
        leftMenuItem.target = self
    }
    
    private func setupMainLayoutWithSnapKit() {
        view.addSubview(topSubView)
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

extension MainVC {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
