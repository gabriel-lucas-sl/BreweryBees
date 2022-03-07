//
//  Favorite.swift
//  BreweryBess
//
//  Created by Danilo Rodrigues da Silva on 21/02/22.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var name = ""
    @Persisted var brewery_type = ""
    @Persisted var average = 0.0
}
