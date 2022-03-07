//
//  MyEvaluationsViewModel.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 02/03/22.
//

class MyEvaluationsViewModel {
    private let breweryRepository: BreweryRepositoryProtocol
    private(set) var myEvaluations: [Brewery] = []
    
    var onShowMyEvaluations: (([Brewery], Int) -> Void)?
    
    init(repository: BreweryRepositoryProtocol) {
        self.breweryRepository = repository
        self.myEvaluations = []
    }
    
    func fetchMyEvaluation(for email: String) {
        breweryRepository.getMyEvaluations(email: email) { breweries, statusCode in
            self.myEvaluations = []
            self.myEvaluations.append(contentsOf: breweries)
            self.onShowMyEvaluations?(self.myEvaluations, statusCode)
        }
    }
    
}
