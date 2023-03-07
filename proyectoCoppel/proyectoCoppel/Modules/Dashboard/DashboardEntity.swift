//
//  DashboardEntity.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 05/03/23.
//

import Foundation
enum typeFilter: String {
    case popular = "Popular"
    case top = "Top Raiting"
    case onTV = "On TV"
    case today = "Airing Today"
}
struct ResultSetTable: Codable {
  var backdropPath     : String?   = nil
  var firstAirDate     : String?   = nil
  var genreIds         : [Int]?    = []
  var id               : Int?      = nil
  var name             : String?   = nil
  var originCountry    : [String]? = []
  var originalLanguage : String?   = nil
  var originalName     : String?   = nil
  var overview         : String?   = nil
  var popularity       : Double?   = nil
  var posterPath       : String?   = nil
  var voteAverage      : Double?   = nil
  var voteCount        : Int?      = nil
  enum CodingKeys: String, CodingKey {
    case backdropPath     = "backdrop_path"
    case firstAirDate     = "first_air_date"
    case genreIds         = "genre_ids"
    case id               = "id"
    case name             = "name"
    case originCountry    = "origin_country"
    case originalLanguage = "original_language"
    case originalName     = "original_name"
    case overview         = "overview"
    case popularity       = "popularity"
    case posterPath       = "poster_path"
    case voteAverage      = "vote_average"
    case voteCount        = "vote_count"
  
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    backdropPath     = try values.decodeIfPresent(String.self   , forKey: .backdropPath     )
    firstAirDate     = try values.decodeIfPresent(String.self   , forKey: .firstAirDate     )
    genreIds         = try values.decodeIfPresent([Int].self    , forKey: .genreIds         )
    id               = try values.decodeIfPresent(Int.self      , forKey: .id               )
    name             = try values.decodeIfPresent(String.self   , forKey: .name             )
    originCountry    = try values.decodeIfPresent([String].self , forKey: .originCountry    )
    originalLanguage = try values.decodeIfPresent(String.self   , forKey: .originalLanguage )
    originalName     = try values.decodeIfPresent(String.self   , forKey: .originalName     )
    overview         = try values.decodeIfPresent(String.self   , forKey: .overview         )
    popularity       = try values.decodeIfPresent(Double.self   , forKey: .popularity       )
    posterPath       = try values.decodeIfPresent(String.self   , forKey: .posterPath       )
    voteAverage      = try values.decodeIfPresent(Double.self   , forKey: .voteAverage      )
    voteCount        = try values.decodeIfPresent(Int.self      , forKey: .voteCount        )
 
  }
  init() {
  }
}
struct ResponseTvShows: Codable, ClassDescribing{
    var page: Int?
    var resultSet: [ResultSetTable]?
    var totalPage: Int
    var totalResults: Int
    enum CodingKeys: String, CodingKey {
      case page
      case resultSet = "results"
      case totalPage = "total_pages"
      case totalResults = "total_results"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        resultSet = try values.decodeIfPresent([ResultSetTable].self, forKey: .resultSet)
        totalPage = try values.decode(Int.self, forKey: .totalPage)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
 
    }
}
