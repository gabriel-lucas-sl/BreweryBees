//
//  BreweyApiProtocol.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 17/02/22.
//

import Foundation

protocol BreweryApiProtocol {
    func getTopTen(completion: @escaping ([Brewery]) -> Void)
    func postEvaluation(brewery: BreweryEvaluation, completion: @escaping (Int) -> Void)
    func getByCity(city: String, completion: @escaping ([Brewery], Int) -> Void)
    func getByID(_ id: String, completion: @escaping (Brewery?, Int) -> Void)
    func getMyEvaluationsByEmail(_ email: String, completion: @escaping ([Brewery], Int) -> Void)
}
