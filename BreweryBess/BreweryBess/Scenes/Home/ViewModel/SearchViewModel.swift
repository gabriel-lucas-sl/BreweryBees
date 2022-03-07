//
//  SearchViewModel.swift
//  BreweryBess
//
//  Created by Francisco Santana Cardoso on 19/02/22.
//

import Foundation
import UIKit

enum OrdenationBreweryType: String {
    case evaluetion = "A a Z"
    case alphabetic = "Notas"
}

class SearchViewModel {
    
    private let breweryRepository: BreweryRepositoryProtocol
    
    var searchResultList: [Brewery]
    var listOrder: [Brewery]
    var searchResult: (([Brewery], Int) -> Void)?
    var searchResultReorder: (([Brewery]) -> Void)?
    
    init(breweryRepository: BreweryRepositoryProtocol) {
        self.breweryRepository = breweryRepository
        self.searchResultList = []
        self.listOrder = []
    }
    
    func savefavorite (favorite: Favorite) {
        do {
           try self.breweryRepository.saveFavorite(favorite)
        }catch {
            return
        }
    }
    
    func ordenationBrewery (breweries: [Brewery], Order: OrdenationBreweryType) -> [Brewery] {
        
        return Order == .alphabetic ? breweries.sorted {$0.city < $1.city} : breweries.sorted {$0.average > $1.average}
        
    }
    
    func search(city: String) {
        self.breweryRepository.loadResultSearchHome(city: city) {[weak self] breweries, statusRequest in
            
            self?.searchResultList = breweries
            
            self?.listOrder = self?.ordenationBrewery(breweries: self?.searchResultList ?? breweries, Order: .evaluetion) ?? breweries
            
            self?.searchResult?(self?.listOrder ?? breweries, statusRequest)
        }
    }
    
    func reorder (Order: OrdenationBreweryType) {
         self.listOrder = self.ordenationBrewery(breweries: self.searchResultList, Order: Order)
        self.searchResultReorder!(self.listOrder)
    }
}
