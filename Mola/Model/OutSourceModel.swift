//
//  MyOrderModel.swift
//  Mola
//
//  Created by 김민창 on 2021/05/17.
//

import Foundation

struct MyId: Encodable {
    let id : Int
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
    }
}

struct OutSourceList: Decodable {
    let status: Int
    let outSources: [OutSource]
}

struct OutSource: Decodable{
    let id: Int
    let requirements: String
    let imgTotal: Int
    let imgCompleted: Int
    let credit: Int
    let title: String
    let completedImageList: [CompletedImage]
}

struct CompletedImage: Decodable {
    let id: Int
    let url: String
    let height: Double
    let width: Double
    let xcoordinate: Double
    let ycoordinate: Double
}

