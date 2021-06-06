//
//  String+Extansion.swift
//  Mola
//
//  Created by 김민창 on 2021/04/29.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordFormat = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@ ", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
    
    var isVaildPhoneNum: Bool {
        let phoneNumFormat = "^(?=.*[0-9]).{9,}$"
        let phoneNumPredicate = NSPredicate(format: "SELF MATCHES %@ ", phoneNumFormat)
        return phoneNumPredicate.evaluate(with: self)
    }
    
    var isVaildCredit: Bool {
        let creditFormat = "^(?=.*[0-9]).{1,2}"
        let creditPredicate = NSPredicate(format: "SELF MATCHES %@ ", creditFormat)
        return creditPredicate.evaluate(with: self)
    }
}
