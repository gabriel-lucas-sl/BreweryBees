//
//  BreweryApi.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 17/02/22.
//

import Foundation

class BreweryApi: BreweryApiProtocol {
    
    func getTopTen(completion: @escaping ([Brewery]) -> Void) {
        HTTP.get.request(url: BuildBreweryRequest.topTen.url) { data, response, errorMessage in
            if let errorMessage = errorMessage {
                print(errorMessage)
                completion([])
                return
            }
            
            guard let data = data, let response = response else {
                completion([])
                return
            }
            
            switch response.statusCode {
            case 200:
                let breweries: [Brewery] = (try? JSONDecoder().decode(Array<Brewery>.self, from: data)) ?? []
                completion(breweries)
                return
            default:
                completion([])
                return
            }
        }
    }
    
    public func postEvaluation(brewery: BreweryEvaluation, completion: @escaping (Int) -> Void) {

        HTTP.post.request(url: BuildBreweryRequest.evaluate.url, body: ["email": brewery.email,
                                                                 "brewery_id": brewery.id,
                                                                 "evaluation_grade": brewery.evaluation]) { _, response, errorMessage in
            if let errorMessage = errorMessage {
                print(errorMessage)
                completion(404)
                return
            }
            guard let response = response else {
                completion(404)
                return
            }
                completion(response.statusCode)
            }
    }
    
    func getByCity(city: String, completion: @escaping ([Brewery], Int) -> Void) {
        HTTP.get.request(url: BuildBreweryRequest.search(city: city).url) { data, response, errorMessage in
            
            if let errorMessage = errorMessage {
                print(errorMessage)
                completion([], 0)
                return
            }
            
            guard let data = data, let response = response else {
                completion([], 0)
                return
            }
            
            switch response.statusCode {
            case 200:
                let breweries: [Brewery] = (try? JSONDecoder().decode(Array<Brewery>.self, from: data)) ?? []
                    completion(breweries, 200)
                    return
            case 400:
                completion([], 400)
                return
            case 404:
                completion([], 404)
                return
            default:
                completion([], 500)
                return
            }
        }
    }

    func getByID(_ id: String, completion: @escaping (Brewery?, Int) -> Void) {
        
        HTTP.get.request(url: BuildBreweryRequest.searchByID(id: id).url) { data, response, errorMessage in
            
            if let errorMessage = errorMessage {
                print(errorMessage)
                return
            }
            
            guard let data = data, let response = response else {return}
            
            switch response.statusCode {
            case 200:
                guard let brewery: Brewery = (try? JSONDecoder().decode(Brewery.self, from: data)) else {return}
                completion(brewery, 200)
                return
            case 400:
                completion(nil, 400)
            case 404:
                completion(nil, 404)
            case 500:
                completion(nil, 500)
            default:
                return
            }
            
        }
    }
    
    func getMyEvaluationsByEmail(_ email: String, completion: @escaping ([Brewery], Int) -> Void) {
        HTTP.get.request(url: BuildBreweryRequest.myEvaluations(email: email).url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data, let response = response else { return }
            
            switch response.statusCode {
            case 200:
                guard let brewery: [Brewery] = (try? JSONDecoder().decode((Array<Brewery>.self), from: data)) else { return }
                completion(brewery, 200)
            case 404:
                completion([], 404)
            case 500:
                completion([], 500)
            default:
                return
            }
            
        }
    }
}
