//
//  Evaluation.swift
//  BreweryBess
//
//  Created by Danilo Rodrigues da Silva on 21/02/22.
//

import Foundation
import RealmSwift

class Evaluation: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var brewery_id = ""
    @Persisted var email = ""
    @Persisted var rating = 0.0
}
