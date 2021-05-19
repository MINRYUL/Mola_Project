//
//  myPageVC.swift
//  Pods
//
//  Created by 김민창 on 2021/05/11.
//

import UIKit

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigation()
        createUI()
    }
    
    private func setupNavigation() {
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
