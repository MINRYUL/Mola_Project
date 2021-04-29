//
//  SignUpTVC.swift
//  Mola
//
//  Created by 김민창 on 2021/04/28.
//

import UIKit
import SnapKit
import Then
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

public class SignUpCell: UITableViewCell {
   
    static let identifier = "SignUpTableViewCell"
    
//    let boardTitleLabel = UILabel().then {
//        $0.font = .systemFont(ofSize: 17)
//    }
    
    let boardTextField = MDCOutlinedTextField().then {
        $0.font = .systemFont(ofSize: 15)
//        $0.leadingAssistiveLabel.text = "This is helper text"
        $0.sizeToFit()
        $0.tintColor = .systemGray
    }
    
    lazy var stackView =  UIStackView(arrangedSubviews: [boardTextField]).then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createUI() {
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.topMargin.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottomMargin.equalToSuperview().offset(-9)
        }
    }
}
