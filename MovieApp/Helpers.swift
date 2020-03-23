//
//  Helpers.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 22.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import Foundation
public class Helpers {
    static let userDefauls = UserDefaults.standard
    static func setFavorite(id:Int,isFavorite:Bool) {
        var favoriteArray = Helpers.getFavorites()
        if isFavorite{
            favoriteArray.append(id)
            favoriteArray = Array(Set(favoriteArray))
        }
        else{
            favoriteArray.removeAll(where: { $0 == id })
        }
        Helpers.userDefauls.set(favoriteArray, forKey: "favoriteList")
    }
    static func getFavorites() -> [Int] {
        return (Helpers.userDefauls.array(forKey: "favoriteList") as? [Int]) ?? []
    }
}
