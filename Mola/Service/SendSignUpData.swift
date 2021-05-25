//
//  SendSignUpData.swift
//  Mola
//
//  Created by 김민창 on 2021/05/25.
//

import Foundation

let DidSendUserInformateionNotification: Notification.Name = Notification.Name("DidSendUserInformation")

func sendUserInformation(requestURL: String, userInfo: UserInformation) {
    guard let url = URL(string: requestURL) else { return }
                    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"         // http 메서드는 'POST'
            
    do { // request body에 전송할 데이터 넣기
        let jsonObject: [String: Any] = ["email":userInfo.email,"password":userInfo.password,"name":userInfo.name,"phonenum":userInfo.phonenum]
        request.httpBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        print(String(data: request.httpBody!, encoding: .utf8)!)
    } catch {
        print(error.localizedDescription)
    }
            
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept-Type")
    
    let session = URLSession.shared
    session.dataTask(with: request, completionHandler: { (data, response, error) in
        print("전송완료")
    }).resume()
}
