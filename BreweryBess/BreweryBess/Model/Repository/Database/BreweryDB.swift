//
//  BreweryDB.swift
//  BreweryBess
//
//  Created by Danilo Rodrigues da Silva on 22/02/22.
//

import Foundation
import RealmSwift

class BreweryDB: BreweryDBProtocol {
    let db = Database()
    
    func saveFavorite(_ favorite: Favorite) {
        do {
            try db.insert(favorite)
        } catch {
            return
        }
    }
    
    func saveEvaluation(_ evaluation: Evaluation) {
        do {
            try db.insert(evaluation)
        } catch {
            return
        }
    }
    
    func listFavorites(_ sort: String = "name") -> Results<Favorite> {
        return db.select(type(of: Favorite()), sorted: true, sortBy: sort, isAsc: sort == "name" ? true : false)!
    }
    
    func getEvaluated(_ breweryId: String) -> Evaluation? {
        let evaluated =  db.selectFirst(type(of: Evaluation()), query: [
            SelectQuery(
                field: "brewery_id",
                value: breweryId,
                comparison: "==",
                condition: nil)
        ])
        
        return evaluated
    }
    
    func deleteFavorite(_ id: String) {
        do {
            try db.delete(Favorite(), id: id)
        } catch {
            return
        }
    }
}
