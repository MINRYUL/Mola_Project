//
//  PointHistoryCell.swift
//  Mola
//
//  Created by 김민창 on 2021/05/22.
//

import UIKit


class PointHistoryCell: UITableViewCell {
    
    static let identifier = "PointHistoryTableViewCell"

    let typeView = UIView().then() {
        $0.backgroundColor = .white
    }
    
    var pointDate = UILabel().then() {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .darkGray
    }
    
    var pointName = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    var updatePoint = UILabel().then() {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = .black
    }
    
    var updateDetail = UILabel().then() {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .systemGray
    }
    
    let lineView = UIView().then() {
        $0.backgroundColor = .systemGray2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func createUI() {
        contentView.addSubview(pointDate)
        contentView.addSubview(pointName)
        contentView.addSubview(updatePoint)
        contentView.addSubview(updateDetail)
        contentView.addSubview(lineView)
        contentView.addSubview(typeView)
        
        typeView.snp.makeConstraints{ make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(15)
        }
        
        pointDate.snp.makeConstraints{ make in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(typeView.safeAreaLayoutGuide.snp.trailing).offset(10)
        }
        
        pointName.snp.makeConstraints{ make in
            make.top.equalTo(pointDate.safeAreaLayoutGuide.snp.bottom).offset(10)
            make.leading.equalTo(typeView.safeAreaLayoutGuide.snp.trailing).offset(10)
        }
        
        updatePoint.snp.makeConstraints{ make in
            make.top.equalTo(contentView).offset(25)
            make.trailing.equalTo(contentView).offset(-20)
        }
        
        updateDetail.snp.makeConstraints{ make in
            make.top.equalTo(updatePoint.safeAreaLayoutGuide.snp.bottom).offset(6)
            make.trailing.equalTo(contentView).offset(-20)
            make.bottom.equalTo(contentView).offset(-15)
        }

        lineView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-1)
            make.left.right.equalTo(contentView).inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            make.height.equalTo(1)
        }
    }
}
