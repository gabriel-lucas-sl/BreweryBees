//
//  BreweryRepository.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 17/02/22.
//

import Foundation
import RealmSwift

class BreweryRespository: BreweryRepositoryProtocol {
    
    private let api: BreweryApiProtocol
    private let database: BreweryDBProtocol
    
    init(api: BreweryApiProtocol, database: BreweryDBProtocol) {
        self.api = api
        self.database = database
    }
    
    func loadTopTenBreweries(completion: @escaping ([Brewery]) -> Void) {
        api.getTopTen(completion: completion)
    }
    
    func evaluateBrewery(brewery: BreweryEvaluation, completion: @escaping (Int) -> Void) {
        api.postEvaluation(brewery: brewery, completion: completion)
    }
    
    func loadResultSearchHome(city: String, completion: @escaping ([Brewery], Int) -> Void) {
        api.getByCity(city: city, completion: completion)
    }
    
    func loadBreweryDetail(_ id: String, completion: @escaping (Brewery?, Int) -> Void) {
        api.getByID(id, completion: completion)
    }
    
    func getMyEvaluations(email: String, completion: @escaping ([Brewery], Int) -> Void) {
        api.getMyEvaluationsByEmail(email, completion: completion)
    }
    
    func saveFavorite(_ favorite: Favorite) {
        database.saveFavorite(favorite)
    }
    
    func saveEvaluation(_ evaluation: Evaluation) {
        database.saveEvaluation(evaluation)
    }
    
    func listFavorites(_ sort: String) -> Results<Favorite> {
        database.listFavorites(sort)
    }
    
    func getEvaluated(_ breweryId: String) -> Evaluation? {
        database.getEvaluated(breweryId)
    }
    
    func deleteFavorite(_ id: String) {
        database.deleteFavorite(id)
    }
}
