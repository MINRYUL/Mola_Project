//
//  SendSignUpData.swift
//  Mola
//
//  Created by 김민창 on 2021/05/25.
//

import Foundation
import Alamofire

class AlamofireClient {
    static let shared: AlamofireClient = AlamofireClient()
    
    //request 실행중 다른 request가 들어오면 현재 진행중인 oldValue cancel 후 새로운 request 실행
    private var request: DataRequest? {
        didSet{
            oldValue?.cancel()
        }
    }
    
    private init() { }
    
    func sendUserInformation(requestURL: String, userInfo: UserInformation, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
        AF.request(requestURL,
                   method: .post,
                   parameters: userInfo,
                   encoder: JSONParameterEncoder.default)
            .responseData(completionHandler: completionHandler)
    }
    
    func requestUserLogin(requestURL: String, loginData: LoginData, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
        AF.request(requestURL,
                   method: .post,
                   parameters: loginData,
                   encoder: JSONParameterEncoder.default)
            .responseData(completionHandler: completionHandler)
    }
}

