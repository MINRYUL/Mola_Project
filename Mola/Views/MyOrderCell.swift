//
//  MyOrderCell.swift
//  Mola
//
//  Created by 김민창 on 2021/05/17.
//

import UIKit

class MyOrderCell: UITableViewCell {
    
    static let identifier = "MyOrderTableViewCell"

    var labelNameLabel = UILabel().then() {
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    var progressLabel = UILabel().then() {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
    }
    
    var progressBar = UIProgressView()
    
    var detailLabel = UILabel().then() {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemBlue
        $0.text = "자세히 보기"
    }
    
    lazy var stackView =  UIStackView(arrangedSubviews: [labelNameLabel, progressLabel, progressBar]).then {
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 7
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
        contentView.addSubview(detailLabel)
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.topMargin.bottomMargin.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-80)
        }
        
        detailLabel.snp.makeConstraints{ make in
            make.leading.equalTo(stackView.safeAreaLayoutGuide.snp.trailing).offset(0)
            make.top.equalToSuperview().offset(18)
        }
    }
}
