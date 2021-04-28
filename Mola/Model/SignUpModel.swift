//
//  SignUpModel.swift
//  Mola
//
//  Created by 김민창 on 2021/04/28.
//

import Foundation

struct SignUpCategory {
    let name: String
    let textField: [TextField]
}

struct TextField {
    let label: String
    let placeHolder: String
    let helpText: String
}
