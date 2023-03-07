//
//  ProfileEntity.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//

import Foundation
struct SessionIdRequest: Codable {
    let sessionId: String
    private enum CodingKeys: String, CodingKey {
        case sessionId = "request_token"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sessionId, forKey: .sessionId)
    }
}

struct ResponseSessionId: Codable, ClassDescribing {
    var requestToken : String?
    var success: Bool?
  enum CodingKeys: String, CodingKey {

    case requestToken = "session_id"
    case success
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      requestToken = try values.decodeIfPresent(String.self , forKey: .requestToken )
      success = try values.decodeIfPresent(Bool.self , forKey: .success )
 
  }
}
struct ResponseGetProfile: Codable, ClassDescribing {

  var avatar       : Avatar? = Avatar()
  var id           : Int?    = nil
  var iso6391      : String? = nil
  var iso31661     : String? = nil
  var name         : String? = nil
  var includeAdult : Bool?   = nil
  var username     : String? = nil

  enum CodingKeys: String, CodingKey {

    case avatar       = "avatar"
    case id           = "id"
    case iso6391      = "iso_639_1"
    case iso31661     = "iso_3166_1"
    case name         = "name"
    case includeAdult = "include_adult"
    case username     = "username"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    avatar       = try values.decodeIfPresent(Avatar.self , forKey: .avatar       )
    id           = try values.decodeIfPresent(Int.self    , forKey: .id           )
    iso6391      = try values.decodeIfPresent(String.self , forKey: .iso6391      )
    iso31661     = try values.decodeIfPresent(String.self , forKey: .iso31661     )
    name         = try values.decodeIfPresent(String.self , forKey: .name         )
    includeAdult = try values.decodeIfPresent(Bool.self   , forKey: .includeAdult )
    username     = try values.decodeIfPresent(String.self , forKey: .username     )
 
  }

  init() {

  }

}
struct Avatar: Codable {
  var gravatarData : gravatar?
  var tmdbData: tmdb?

  enum CodingKeys: String, CodingKey {
    case gravatarData = "gravatar"
    case tmdbData = "tmdb"
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      gravatarData = try values.decodeIfPresent(gravatar.self , forKey: .gravatarData )
      tmdbData     = try values.decodeIfPresent(tmdb.self     , forKey: .tmdbData     )
 
  }
  init() {
  }
}
struct gravatar: Codable {
  var hash : String?
  enum CodingKeys: String, CodingKey {
    case hash = "hash"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    hash = try values.decodeIfPresent(String.self , forKey: .hash )
 
  }
}
struct tmdb: Codable {
  var avatarPath : String?
  enum CodingKeys: String, CodingKey {
    case avatarPath = "avatar_path"
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

      avatarPath = try values.decodeIfPresent(String.self , forKey: .avatarPath )
 
  }
}
