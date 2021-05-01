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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

      }
    
    private func setupNavigation() {
        self.navigationItem.title = "모두의 라벨링"
        
        UINavigationBar.appearance().isTranslucent = false
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        self.navigationItem.setLeftBarButtonItems([leftMenuItem], animated: true)
        
        leftMenuItem.target = self
    }
    
    private func setupMainLayoutWithSnapKit() {
        
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
