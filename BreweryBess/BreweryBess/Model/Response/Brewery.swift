//
//  BrewerySearch.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 17/02/22.
//

import Foundation

public struct Brewery: Decodable {
    let id: String
    let name: String
    let brewery_type: String
    let street: String?
    let address2: String?
    let address3: String?
    let city: String
    let state: String?
    let postal_code: String
    let country: String
    let longitude: Double?
    let latitude: Double?
    let website_url: String?
    let phone: String?
    let average: Double
    let size_evaluations: Int
    let photos: [String]?
}

public struct BreweryEvaluation: Decodable {
    public let id: String
    public let email: String
    public let evaluation: Double
    public var statusCode: Int = 0
    
    public init(email: String, id: String, evaluate: Double) {
        self.email = email
        self.id = id
        self.evaluation = evaluate
    }
}
