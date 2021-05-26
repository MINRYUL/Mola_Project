//
//  UserModel.swift
//  
//
//  Created by 김민창 on 2021/05/25.
//

import Foundation

struct UserDetail {
    static let shared: UserDetail = UserDetail()

    var id : Int?
    var email : String?
    var name : String?
    var password : String?
    var point : Int?
    var phonenum : String?
    
    private init() { }
}

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
