//
//  MovieDetailEntity.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//

import Foundation
struct ResponseMovieDetail: Codable, ClassDescribing {
  var adult               : Bool?                  = nil
  var backdropPath        : String?                = nil
  var createdBy           : [CreatorEntity]?           = []
  var episodeRunTime      : [Int]?                 = []
  var firstAirDate        : String?                = nil
  var genres              : [GenereEntity]?              = []
  var homepage            : String?                = nil
  var id                  : Int?                   = nil
  var inProduction        : Bool?                  = nil
  var languages           : [String]?              = []
  var lastAirDate         : String?                = nil
  var lastEpisodeToAir    : EpisodeDetail?      = EpisodeDetail()
  var name                : String?                = nil
  var nextEpisodeToAir    : EpisodeDetail?      = EpisodeDetail()
  var numberOfEpisodes    : Int?                   = nil
  var numberOfSeasons     : Int?                   = nil
  var originCountry       : [String]?              = []
  var originalLanguage    : String?                = nil
  var originalName        : String?                = nil
  var overview            : String?                = nil
  var popularity          : Double?                = nil
  var posterPath          : String?                = nil
  var productionCompanies : [ProductionCompanies]? = []
  var status              : String?                = nil
  var tagline             : String?                = nil
  var type                : String?                = nil
  var voteAverage         : Double?                = nil
  var voteCount           : Int?                   = nil
  enum CodingKeys: String, CodingKey {
    case adult               = "adult"
    case backdropPath        = "backdrop_path"
    case createdBy           = "created_by"
    case episodeRunTime      = "episode_run_time"
    case firstAirDate        = "first_air_date"
    case genres              = "genres"
    case homepage            = "homepage"
    case id                  = "id"
    case inProduction        = "in_production"
    case languages           = "languages"
    case lastAirDate         = "last_air_date"
    case lastEpisodeToAir    = "last_episode_to_air"
    case name                = "name"
    case nextEpisodeToAir    = "next_episode_to_air"
    case numberOfEpisodes    = "number_of_episodes"
    case numberOfSeasons     = "number_of_seasons"
    case originCountry       = "origin_country"
    case originalLanguage    = "original_language"
    case originalName        = "original_name"
    case overview            = "overview"
    case popularity          = "popularity"
    case posterPath          = "poster_path"
    case productionCompanies = "production_companies"
    case status              = "status"
    case tagline             = "tagline"
    case type                = "type"
    case voteAverage         = "vote_average"
    case voteCount           = "vote_count"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    adult               = try values.decodeIfPresent(Bool.self                  , forKey: .adult               )
    backdropPath        = try values.decodeIfPresent(String.self                , forKey: .backdropPath        )
    createdBy           = try values.decodeIfPresent([CreatorEntity].self           , forKey: .createdBy           )
    episodeRunTime      = try values.decodeIfPresent([Int].self                 , forKey: .episodeRunTime      )
    firstAirDate        = try values.decodeIfPresent(String.self                , forKey: .firstAirDate        )
    genres              = try values.decodeIfPresent([GenereEntity].self              , forKey: .genres              )
    homepage            = try values.decodeIfPresent(String.self                , forKey: .homepage            )
    id                  = try values.decodeIfPresent(Int.self                   , forKey: .id                  )
    inProduction        = try values.decodeIfPresent(Bool.self                  , forKey: .inProduction        )
    languages           = try values.decodeIfPresent([String].self              , forKey: .languages           )
    lastAirDate         = try values.decodeIfPresent(String.self                , forKey: .lastAirDate         )
    lastEpisodeToAir    = try values.decodeIfPresent(EpisodeDetail.self      , forKey: .lastEpisodeToAir    )
    name                = try values.decodeIfPresent(String.self                , forKey: .name                )
    nextEpisodeToAir    = try values.decodeIfPresent(EpisodeDetail.self      , forKey: .nextEpisodeToAir    )
    numberOfEpisodes    = try values.decodeIfPresent(Int.self                   , forKey: .numberOfEpisodes    )
    numberOfSeasons     = try values.decodeIfPresent(Int.self                   , forKey: .numberOfSeasons     )
    originCountry       = try values.decodeIfPresent([String].self              , forKey: .originCountry       )
    originalLanguage    = try values.decodeIfPresent(String.self                , forKey: .originalLanguage    )
    originalName        = try values.decodeIfPresent(String.self                , forKey: .originalName        )
    overview            = try values.decodeIfPresent(String.self                , forKey: .overview            )
    popularity          = try values.decodeIfPresent(Double.self                , forKey: .popularity          )
    posterPath          = try values.decodeIfPresent(String.self                , forKey: .posterPath          )
    productionCompanies = try values.decodeIfPresent([ProductionCompanies].self , forKey: .productionCompanies )
    status              = try values.decodeIfPresent(String.self                , forKey: .status              )
    tagline             = try values.decodeIfPresent(String.self                , forKey: .tagline             )
    type                = try values.decodeIfPresent(String.self                , forKey: .type                )
    voteAverage         = try values.decodeIfPresent(Double.self                , forKey: .voteAverage         )
    voteCount           = try values.decodeIfPresent(Int.self                   , forKey: .voteCount           )
  }
}

struct CreatorEntity: Codable {

      var id          : Int?    = nil
      var creditId    : String? = nil
      var name        : String? = nil
      var gender      : Int?    = nil
      var profilePath : String? = nil

      enum CodingKeys: String, CodingKey {

        case id          = "id"
        case creditId    = "credit_id"
        case name        = "name"
        case gender      = "gender"
        case profilePath = "profile_path"
      
      }

      init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id          = try values.decodeIfPresent(Int.self    , forKey: .id          )
        creditId    = try values.decodeIfPresent(String.self , forKey: .creditId    )
        name        = try values.decodeIfPresent(String.self , forKey: .name        )
        gender      = try values.decodeIfPresent(Int.self    , forKey: .gender      )
        profilePath = try values.decodeIfPresent(String.self , forKey: .profilePath )
     
      }

      init() {

      }

    }
    struct GenereEntity: Codable {
      var id   : Int?    = nil
      var name : String? = nil
      enum CodingKeys: String, CodingKey {
        case id   = "id"
        case name = "name"
      }

      init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id   = try values.decodeIfPresent(Int.self    , forKey: .id   )
        name = try values.decodeIfPresent(String.self , forKey: .name )
     
      }

      init() {

      }
    }
    struct ProductionCompanies: Codable {

      var id            : Int?    = nil
      var logoPath      : String? = nil
      var name          : String? = nil
      var originCountry : String? = nil

      enum CodingKeys: String, CodingKey {

        case id            = "id"
        case logoPath      = "logo_path"
        case name          = "name"
        case originCountry = "origin_country"
      
      }

      init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id            = try values.decodeIfPresent(Int.self    , forKey: .id            )
        logoPath      = try values.decodeIfPresent(String.self , forKey: .logoPath      )
        name          = try values.decodeIfPresent(String.self , forKey: .name          )
        originCountry = try values.decodeIfPresent(String.self , forKey: .originCountry )
     
      }
    }
    struct EpisodeDetail: Codable {

              var id            : Int?    = nil
              var logoPath      : String? = nil
              var name          : String? = nil
              var originCountry : String? = nil
        var airDate: String?
              enum CodingKeys: String, CodingKey {

                case id            = "id"
                case logoPath      = "logo_path"
                case name          = "name"
                case originCountry = "origin_country"
                case airDate = "air_date"
              
              }
              init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id            = try values.decodeIfPresent(Int.self    , forKey: .id            )
                logoPath      = try values.decodeIfPresent(String.self , forKey: .logoPath      )
                name          = try values.decodeIfPresent(String.self , forKey: .name          )
                originCountry = try values.decodeIfPresent(String.self , forKey: .originCountry )
                airDate = try values.decodeIfPresent(String.self , forKey: .airDate )
             
              }
        init() {}
    }
struct movieVideoResponse: Codable, ClassDescribing {
  var id: Int?
  var results: [ResultVideo]?
  enum CodingKeys: String, CodingKey {
    case id      = "id"
    case results = "results"
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(Int.self       , forKey: .id      )
    results = try values.decodeIfPresent([ResultVideo].self , forKey: .results )
  }
  init() {
  }
}
struct ResultVideo: Codable {

  var iso6391     : String? = nil
  var iso31661    : String? = nil
  var name        : String? = nil
  var key         : String? = nil
  var site        : String? = nil
  var size        : Int?    = nil
  var type        : String? = nil
  var official    : Bool?   = nil
  var publishedAt : String? = nil
  var id          : String? = nil

  enum CodingKeys: String, CodingKey {

    case iso6391     = "iso_639_1"
    case iso31661    = "iso_3166_1"
    case name        = "name"
    case key         = "key"
    case site        = "site"
    case size        = "size"
    case type        = "type"
    case official    = "official"
    case publishedAt = "published_at"
    case id          = "id"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    iso6391     = try values.decodeIfPresent(String.self , forKey: .iso6391     )
    iso31661    = try values.decodeIfPresent(String.self , forKey: .iso31661    )
    name        = try values.decodeIfPresent(String.self , forKey: .name        )
    key         = try values.decodeIfPresent(String.self , forKey: .key         )
    site        = try values.decodeIfPresent(String.self , forKey: .site        )
    size        = try values.decodeIfPresent(Int.self    , forKey: .size        )
    type        = try values.decodeIfPresent(String.self , forKey: .type        )
    official    = try values.decodeIfPresent(Bool.self   , forKey: .official    )
    publishedAt = try values.decodeIfPresent(String.self , forKey: .publishedAt )
    id          = try values.decodeIfPresent(String.self , forKey: .id          )
 
  }

  init() {

  }

}
