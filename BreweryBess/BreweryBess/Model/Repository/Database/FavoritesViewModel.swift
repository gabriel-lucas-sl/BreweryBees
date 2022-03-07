//
//  FavoritesViewModel.swift
//  BreweryBess
//
//  Created by Danilo Rodrigues da Silva on 23/02/22.
//

import Foundation
import RealmSwift

enum FavoritesOrder: String {
    case average = "A a Z"
    case name = "Notas"
}

class FavoritesViewModel {
    private let breweryRepository: BreweryRepositoryProtocol
    var favoritesList: Results<Favorite>?
    var favoritesResult: ((Results<Favorite>) -> Void)?
    
    init(breweryRepository: BreweryRepositoryProtocol) {
        self.breweryRepository = breweryRepository
    }
    
    func list(_ sort: FavoritesOrder) {
        favoritesList = self.breweryRepository.listFavorites(String(describing: sort))
        self.favoritesResult?(favoritesList!)
    }
    
    func delete(_ id: String) {
        self.breweryRepository.deleteFavorite(id)
    }
}
