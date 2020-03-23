//
//  BaseResponse.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 22.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import Foundation
public class BaseResponse : Codable{
    public var errors: [String]? = []
    private enum CodingKeys: String, CodingKey {
        case errors
    }
    public init(errors: [String]? = []) {
        self.errors = errors
    }
}
