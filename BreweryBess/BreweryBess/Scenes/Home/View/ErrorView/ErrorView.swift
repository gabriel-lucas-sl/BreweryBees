//
//  ErrorView.swift
//  BreweryBess
//
//  Created by Danilo Rodrigues da Silva on 07/02/22.
//

import UIKit

enum ErrorTitle: String {
    case resultError =  "Nenhum resultado encontrado para a busca"
    case searchTextError = "Nenhum termo digitado"
}

class ErrorView: UIView {
    
    @IBOutlet weak var errorTitleLabel: UILabel!
    
    func setErrorType(_ error: ErrorTitle ) {
        errorTitleLabel.text = error.rawValue
    }
}
