//
//  DataExecuter.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 22.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import Foundation
public class DataExecuter {
    static var baseURL = "https://api.themoviedb.org/3"
    static let defaultManager = URLSession.shared
    static let access_token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZDI3NDAyZTgzODAxNDMzYmE4MWQ3MDk1NmVlNjk5NyIsInN1YiI6IjVlNzcyZGZiMzU3YzAwMDAxMzUwOWFhOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tq2e3QObE79o-wuBX95Y5aRTCSlnZziGgmkqVj5HVLY"
    public typealias ApiRequestBuilder = (url: String, action: String)
    private static func router(builder: ApiRequestBuilder,headers:[String:String]? = nil) -> URLRequest {
        
        var url = URL(string: baseURL + builder.url)
        if url  == nil {
            url = URL.init(string: baseURL)
        }
        var request = URLRequest.init(url: url!)
        
        request.httpMethod = builder.action
        request.timeoutInterval = 60
        request.allHTTPHeaderFields = headers
        return request
    }
    
    class Request{
        let builder: ApiRequestBuilder
        var headers:[String:String]?
        let decoder = JSONDecoder()
        public init(builder: ApiRequestBuilder,headers:[String:String]=["Authorization":"Bearer \(DataExecuter.access_token)"]){
            self.builder = builder
            self.headers = headers
        }
        public func execute<T:Decodable>(type:T.Type,closure: @escaping (T?,Bool,String?)->Void) {
            let request = DataExecuter.router(builder: builder,headers:  headers)
            DataExecuter.defaultManager.dataTask(with: request) { data, response, error in
               if let data = data {
                  do{
                      
                      let object =  try self.decoder.decode(type.self, from: data)
                      if ((object as? BaseResponse)?.errors?.count ?? 0) > 0{
                          closure(nil, false,(object as? BaseResponse)?.errors?.first ?? String.unExpectedError)
                      }
                      else{
                          closure(object,true,nil)
                      }
                      
                  }
                  catch{
                      closure(nil, false,String.unExpectedError)
                  }
                }
               else{
                    closure(nil, false,String.unExpectedError)
                }
            }.resume()
        }
    }
}
