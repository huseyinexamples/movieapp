//
//  DataExecuterConstants.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 22.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import Foundation
extension DataExecuter{
    static var language = "en-EN"
    enum Movie {
        case getPopularMovies(page:Int),moviePoster(width:Int,posterPath:String)
        public func builder() -> ApiRequestBuilder {
            switch self {
                
            case let .getPopularMovies(page):
                return (url:"/movie/popular?language=\(DataExecuter.language)&page=\(page)", action: "GET")
            case let .moviePoster(width,posterPath):
                return (url:"https://image.tmdb.org/t/p/w\(width)\(posterPath)", action: "GET")
            }
            
        }
        
        
    }
}

