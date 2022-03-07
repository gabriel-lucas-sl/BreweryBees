//
//  HomeViewModel.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 17/02/22.
//

import Foundation

class CarouselViewModel {
    private let breweryRepository: BreweryRepositoryProtocol
    private(set) var topTen: [Brewery] = []
    
    var onShowTopTen: (([Brewery]) -> Void)?
    
    init(breweryRepository: BreweryRepositoryProtocol) {
        self.breweryRepository = breweryRepository
    }
    
    func fetchTopTenCarousel() {
        breweryRepository.loadTopTenBreweries { breweries in
            self.topTen.append(contentsOf: breweries)
            self.onShowTopTen?(self.topTen)
        }
    }
}
