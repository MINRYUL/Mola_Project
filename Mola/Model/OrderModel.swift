//
//  OrderModel.swift
//  Mola
//
//  Created by 김민창 on 2021/05/05.
//

import Foundation

struct OrderList {
    let name: String
    let order: [Order]
}

struct Order {
    let name: String
    let detail: String
}
