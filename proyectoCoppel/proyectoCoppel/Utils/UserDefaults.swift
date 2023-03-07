//
//  UserDefaults.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//
import Foundation
class CoppelUserDefaults {
    static let tokenKey: String = "tokenid"
    static let sessionKey: String = "sessionId"
    static func setTokenKey(value: String){
        UserDefaults.standard.set(value, forKey: tokenKey)
    }
    //MARK: Retrieve User Data
    static func getTokenKey() -> String {
        return ((UserDefaults.standard.object(forKey: tokenKey) as? String) ?? "")
    }
    static func setSessionKey(value: String){
        UserDefaults.standard.set(value, forKey: sessionKey)
    }
    //MARK: Retrieve User Data
    static func getSessionKey() -> String {
        return ((UserDefaults.standard.object(forKey: sessionKey) as? String) ?? "")
    }
}
