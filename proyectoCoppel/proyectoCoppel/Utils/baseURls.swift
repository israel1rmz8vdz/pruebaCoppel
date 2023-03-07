//
//  baseURls.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//

import Foundation
struct baseUrl {
    static let base = "https://api.themoviedb.org/3/"
    static let movieDetail = "tv/{idMovie}?api_key=eef5a2dbfd75c2d32d624dbeb2d5d4f6&language=en-US"
    static let movieVideo = "tv/{idMovie}/videos?api_key=eef5a2dbfd75c2d32d624dbeb2d5d4f6&language=en-US"
    static let image = "https://image.tmdb.org/t/p/w500"
}
