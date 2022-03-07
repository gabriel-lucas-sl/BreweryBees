//
//  NoEvaluationsView.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 01/03/22.
//

import UIKit

class NoEvaluationsView: UIView {
    
    // MARK: - PropertiesSession
    
    private let titleLabel: UILabel = {
        let label = UILabel().setBoldLabel(text: "Nenhuma cervejaria avaliada", size: 20, color: .black)
        label.textAlignment = .center
        label.numberOfLines = 3
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let text = " Você ainda não avaliou nenhuma cervejaria. Suas cervejarias avaliadas aparecerão aqui."
        let label = UILabel().setNormalLabel(text: text, size: 16, color: .black)
        label.textAlignment = .center
        label.numberOfLines = 5
        
        return label
    }()
    
    // MARK: - LifecycleSession
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func loadView() {
        print("Loading view...")
        let width = UIScreen.main.bounds.size.width - (32 * 2)
        
        addSubview(titleLabel)
        titleLabel.anchor(width: width)

        addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 12, width: width)
    }
}
