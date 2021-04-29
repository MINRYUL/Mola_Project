//
//  SplashVC.swift
//  Mola
//
//  Created by 김민창 on 2021/04/27.
//

import UIKit

class SplashVC: UIViewController {
    
    private var titleimage = UIImageView().then {
        $0.image = UIImage(named: "PriceLabelpng")
        $0.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        self.setupMainLayoutWithSnapKit()
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = true
//        self.tabBarController?.tabBar.isHidden = true
//        self.extendedLayoutIncludesOpaqueBars = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.checkDeviceNetworkStatus()
    }
    
    func checkDeviceNetworkStatus() {
        if(DeviceManager.shared.networkStatus) {
            sleep(1)
            let loginVC = LoginVC()
            self.navigationController?.pushViewController(loginVC, animated: true)
            
        } else {
            let alert: UIAlertController = UIAlertController(title: "네트워크 상태 확인", message: "네트워크가 불안정 합니다.", preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "다시 시도", style: .default, handler: { (ACTION) in
                self.checkDeviceNetworkStatus()
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    private func setupMainLayoutWithSnapKit() {
        view.addSubview(titleimage)
        
        titleimage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
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
