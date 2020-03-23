//
//  Movie.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 22.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import Foundation

public struct Movie: Codable,Identifiable {
    public var popularity: Double?
    public var voteCount: Int?
    public var video: Bool?
    public var posterPath: String?
    public var id: Int
    public var adult: Bool?
    public var backdropPath: String?
    public var originalLanguage, originalTitle: String?
    public var genreIDS: [Int]?
    public var title: String?
    public var voteAverage: Double?
    public var overview, releaseDate: String?
    public var isFavorite = false
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }

    public init(popularity: Double?, voteCount: Int?, video: Bool?, posterPath: String?, id: Int, adult: Bool?, backdropPath: String?, originalLanguage: String?, originalTitle: String?, genreIDS: [Int]?, title: String?, voteAverage: Double?, overview: String?, releaseDate: String?) {
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.posterPath = posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
}
