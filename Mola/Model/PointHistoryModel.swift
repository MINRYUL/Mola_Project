//
//  PointHistoryModel.swift
//  Mola
//
//  Created by 김민창 on 2021/05/22.
//

import Foundation

struct PointModel {
    var name: String
    var pointHistory: [PointHistory]
}

struct PointHistory {
    let type: String
    let beforeChange: Int
    let afterChange: Int
    let date: String
}
