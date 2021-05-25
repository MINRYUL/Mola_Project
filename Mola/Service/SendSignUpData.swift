//
//  SendSignUpData.swift
//  Mola
//
//  Created by 김민창 on 2021/05/25.
//

import Foundation
import Alamofire

func sendUserInformation(requestURL: String, userInfo: UserInformation, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
    AF.request(requestURL,
           method: .post,
           parameters: userInfo,
           encoder: JSONParameterEncoder.default)
    .responseData(completionHandler: completionHandler)
}

