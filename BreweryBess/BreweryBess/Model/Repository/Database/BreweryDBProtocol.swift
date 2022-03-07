//
//  BreweryDBProtocol.swift
//  BreweryBess
//
//  Created by Danilo Rodrigues da Silva on 22/02/22.
//

import Foundation
import RealmSwift

protocol BreweryDBProtocol {
    func saveFavorite(_ favorite: Favorite)
    func saveEvaluation(_ evaluation: Evaluation)
    func listFavorites(_ sort: String) -> Results<Favorite>
    func getEvaluated(_ breweryId: String) -> Evaluation?
    func deleteFavorite(_ id: String)
}
