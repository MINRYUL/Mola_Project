//
//  NavigationVC.swift
//  Mola
//
//  Created by 김민창 on 2021/05/01.
//

import Foundation
import UIKit
import MaterialComponents.MaterialNavigationDrawer

class NavigationVC: UIViewController, MDCBottomDrawerHeader {

   let titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Ivoxis"
       label.font = UIFont.boldSystemFont(ofSize: 18)
       label.sizeToFit()
       return label
   }()
   
   let addressLabel: UILabel = {
       let label = UILabel()
       label.text = "drawerHeaderView@xxx.xxx"
       label.sizeToFit()
       return label
   }()
   
   override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = .white

       setLayout()
   }
   
   func setLayout() {
       view.addSubview(titleLabel)
       titleLabel.translatesAutoresizingMaskIntoConstraints = false
       titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
       titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
       
    /*
       view.addSubview(addressLabel)
       addressLabel.translatesAutoresizingMaskIntoConstraints = false
       addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
       addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true*/
   }

}
