//
//  SheetBreweryReviewViewModel.swift
//  BreweryBess
//
//  Created by Jose Mateus Azevedo de Sousa on 18/02/22.
//

import Foundation

class SheetBreweryReviewViewModel {
    let breweryRepository: BreweryRepositoryProtocol
    var brewery: BreweryEvaluation?
    
    init(breweryRepository: BreweryRepositoryProtocol) {
        self.breweryRepository = breweryRepository
    }
    
    var onShowFeedback: ((Int) -> Void)?
    
    func evaluateBrewery() {
        breweryRepository.evaluateBrewery(brewery: brewery!, completion: { [weak self] statusCode in
            self?.brewery!.statusCode = statusCode
            self?.onShowFeedback?(self!.brewery!.statusCode)
        })
    }
    
}
