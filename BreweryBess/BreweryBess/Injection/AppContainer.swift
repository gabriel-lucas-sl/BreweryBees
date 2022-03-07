//
//  AppInjection.swift
//  BreweryBess
//
//  Created by Francisco Santana Cardoso on 16/02/22.
//

import Foundation
import Swinject

class AppContainer {
    public static let shared: Container = {
        let container = Container()
        
        container.register(BreweryApiProtocol.self) { _ in BreweryApi() }
        
        container.register(BreweryDBProtocol.self) { _ in BreweryDB() }
        
        container.register(BreweryRepositoryProtocol.self) { r in
            BreweryRespository(api: r.resolve(BreweryApiProtocol.self)!, database: r.resolve(BreweryDBProtocol.self)!)
        }
        
        container.register(CarouselViewModel.self) { r in
            CarouselViewModel(breweryRepository: r.resolve(BreweryRepositoryProtocol.self)!)
        }
        
        container.register(SheetBreweryReviewViewModel.self) { r in
            SheetBreweryReviewViewModel(breweryRepository: r.resolve(BreweryRepositoryProtocol.self)!)
        }
        
        container.register(SearchViewModel.self) { r in SearchViewModel(breweryRepository: r.resolve(BreweryRepositoryProtocol.self)!) }
        
        container.register(BreweryDetailsViewModel.self) { r in BreweryDetailsViewModel(breweryRepository: r.resolve(BreweryRepositoryProtocol.self)!) }
        
        container.register(FavoritesViewModel.self) { r in FavoritesViewModel(breweryRepository: r.resolve(BreweryRepositoryProtocol.self)!) }
        
        container.register(MyEvaluationsViewModel.self) {  r in MyEvaluationsViewModel(repository: r.resolve(BreweryRepositoryProtocol.self)!) }

        container.register(MyEvaluationsTableView.self) {  _ in MyEvaluationsTableView() }
        
        return container
    }()
}
