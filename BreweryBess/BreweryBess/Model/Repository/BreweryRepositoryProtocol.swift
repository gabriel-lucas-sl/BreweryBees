//
//  BreweryRepositoryProtocol.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 17/02/22.
//

import Foundation
import RealmSwift

protocol BreweryRepositoryProtocol {
    
    func loadTopTenBreweries(completion: @escaping ([Brewery]) -> Void)
    func evaluateBrewery(brewery: BreweryEvaluation, completion: @escaping (Int) -> Void)
    func loadResultSearchHome(city: String, completion: @escaping ([Brewery], Int) -> Void)
    func loadBreweryDetail(_ id: String, completion: @escaping (Brewery?, Int) -> Void)
    func saveFavorite(_ favorite: Favorite)
    func saveEvaluation(_ evaluation: Evaluation)
    func listFavorites(_ sort: String) -> Results<Favorite>
    func getEvaluated(_ breweryId: String) -> Evaluation?
    func deleteFavorite(_ id: String)
    func getMyEvaluations(email: String, completion: @escaping ([Brewery], Int) -> Void)
}
