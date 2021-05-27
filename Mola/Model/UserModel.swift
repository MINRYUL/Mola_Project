//
//  UserModel.swift
//  
//
//  Created by 김민창 on 2021/05/25.
//

import Foundation

struct UserInformation: Encodable {
    let email : String
    let password : String
    let name : String
    let phonenum : String
}

struct LoginData: Encodable {
    let email : String
    let password : String
}
