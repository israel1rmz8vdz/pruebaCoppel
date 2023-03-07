//
//  LoginEntity.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 05/03/23.
//

import Foundation
struct LoginRequest: Codable {
    let userName: String
    let password: String
    let sessionId: String
    private enum CodingKeys: String, CodingKey {
        case userName = "username"
        case password
        case sessionId = "request_token"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userName, forKey: .userName)
        try container.encode(password, forKey: .password)
        try container.encode(sessionId, forKey: .sessionId)
    }
}
struct LoginResponse: Codable, ClassDescribing {
    var success: Bool
    var expiresAt: String?
    var requestToken: String?
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decode(Bool.self, forKey: .success)
        expiresAt = try values.decodeIfPresent(String.self, forKey: .expiresAt)
        requestToken = try values.decodeIfPresent(String.self, forKey: .requestToken)
    }
}
struct LoginSessionIdResponse: Codable, ClassDescribing {
    var success: Bool
    var expiresAt: String?
    var requestToken: String?
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decode(Bool.self, forKey: .success)
        expiresAt = try values.decodeIfPresent(String.self, forKey: .expiresAt)
        requestToken = try values.decodeIfPresent(String.self, forKey: .requestToken)
    }
}
