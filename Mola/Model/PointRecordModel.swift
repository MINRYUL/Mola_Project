//
//  PointHistoryModel.swift
//  Mola
//
//  Created by 김민창 on 2021/05/22.
//

import Foundation

struct PointModel: Decodable {
    let status: Int
    var pointRecord: [PointRecord]
}

struct PointRecord: Decodable {
    let id: Int
    let changeType: String
    let pointBefore: Int
    let pointAfter: Int
    let pointChangeDate: String
}
