//
//  BreweryDetails.swift
//  BreweryBess
//
//  Created by Taila Nayara Saviani on 19/02/22.
//

import Foundation

class BreweryDetailsViewModel {
    
    private let breweryRepository: BreweryRepositoryProtocol
    
    var breweryDetails: Brewery?
        
    var onShowDetails: ((Brewery) -> Void)?
    var onShowError: ((String) -> Void)?
    
    init(breweryRepository: BreweryRepositoryProtocol) {
        self.breweryRepository = breweryRepository
    }

    func fetchBreweryDetails(_ id: String = "") {
        breweryRepository.loadBreweryDetail(id, completion: { [weak self] breweryDetails, statusRequest  in
            self?.breweryDetails = breweryDetails
            guard let details = breweryDetails else {
                self?.handleError(statusRequest)
                return
            }
             self?.onShowDetails?(details)
        })
    }
    
    private func handleError(_ statusRequest: Int) {
        switch statusRequest {
        case 400:
            onShowError?("Payload Error")
        case 404:
            onShowError?("There is no brewery with such id!")
        case 500:
            onShowError?("Internal Error")
        default:
            onShowError?("Unknown Error")
        }
    }
    
}
