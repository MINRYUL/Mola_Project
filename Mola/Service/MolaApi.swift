//
//  SendSignUpData.swift
//  Mola
//
//  Created by 김민창 on 2021/05/25.
//

import Foundation
import Alamofire

class MolaApi {
    static let shared: MolaApi = MolaApi()
    
    //request 실행중 다른 request가 들어오면 현재 진행중인 oldValue cancel 후 새로운 request 실행
    private var request: DataRequest? {
        didSet{
            oldValue?.cancel()
        }
    }
    
    private init() { }
    
    func uploadUserInformation(requestURL: String, userInfo: UserInformation, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
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
    
    func uploadOrder(requestURL: String, order: Order, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
        
        AF.request(requestURL,
                   method: .post,
                   parameters: order,
                   encoder: JSONParameterEncoder.default)
            .responseData(completionHandler: completionHandler)
    }
    
    func uploadDocument(requestURL: String, fileData: FileData, completionHandler : @escaping (AFDataResponse<Data>) -> Void) {
        
        let parameters = [
            "userId" : fileData.userId,
            "outSourceId" : fileData.outSourceId
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            // zip파일 넣어주기
            multipartFormData.append(fileData.file, withName: "file", fileName: fileData.fileName, mimeType: "application/zip")
            // body를 넣어주기
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
        }, to: requestURL, method: .post).responseData(completionHandler: completionHandler)
    }
}
