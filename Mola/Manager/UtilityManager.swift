//
//  Utility.swift
//  Mola
//
//  Created by 김민창 on 2021/05/26.
//

import Foundation

public class UtilityManager{
    
    static let shared: UtilityManager = UtilityManager()
    
    private init() { }

    func jsonStringToDictionary(jsonString: String) -> [String: Any]? {
        if let data = jsonString.data(using: .utf8){
            do{
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            }catch{
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
