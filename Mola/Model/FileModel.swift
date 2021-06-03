//
//  FileModel.swift
//  Mola
//
//  Created by 김민창 on 2021/06/01.
//

import Foundation

struct FileData: Encodable {
    let file : Data
    let fileName : String
    let userId : Int
    let outSourceId : Int
}
