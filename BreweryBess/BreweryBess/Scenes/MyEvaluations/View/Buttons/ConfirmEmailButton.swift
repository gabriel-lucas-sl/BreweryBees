//
//  ConfirmEmailButton.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 01/03/22.
//

import UIKit

class ConfirmEmailButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        setTitle("CONFIRMAR", for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = .mainYellowTint
        layer.cornerRadius = 4
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
