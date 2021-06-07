//
//  ImageModel.swift
//  Mola
//
//  Created by 김민창 on 2021/06/06.
//

import Foundation


struct LabelingImageInfo: Encodable {
    let userId: Int
    let xCoordinate: Float
    let yCoordinate: Float
    let height: Float
    let width: Float
}

struct Image: Decodable {
    let status: Int
    let url: String
    let imageId: Int
    let requirements: String
    let credit: Int
}
