//
//  BuildBreweryRequest.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 17/02/22.
//

import Foundation

public enum BuildBreweryRequest: Router {
    case searchByID(id: String)
    case search(city: String)
    case topTen
    case evaluate
    case myEvaluations(email: String)
    
    public var hostname: String {
            return "https://bootcamp-mobile-01.eastus.cloudapp.azure.com/breweries"
    }
    
    public var url: URL? {
            switch self {
            case .searchByID(let id):
                return URL(string: "\(hostname)/\(id)")
            case .search(let city):
                return URL(string: "\(hostname)?by_city=\(city)")
            case .topTen:
                return URL(string: "\(hostname)/topTen")
            case .evaluate:
                return URL(string: "\(hostname)")
            case .myEvaluations(let email):
                return URL(string: "\(hostname)/myEvaluations/\(email)")
            }
    }
}
