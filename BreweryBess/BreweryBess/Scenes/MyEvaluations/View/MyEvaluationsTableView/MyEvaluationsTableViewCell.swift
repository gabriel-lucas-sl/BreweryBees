//
//  MyEvaluationsTableViewCell.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 28/02/22.
//

import UIKit
import AARatingBar

class MyEvaluationsTableViewCell: UITableViewCell {
    
    // MARK: - PropertiesSession
    
    private lazy var breweryNameLabel: UILabel = {
        let label = UILabel().setBoldLabel(text: "Cervejaria A", size: 16, color: .black)
        return label
    }()
    
    private let iconLetterLabel: UILabel = {
        let label = UILabel().setBoldLabel(text: "A", size: 32, color: .mainYellowTint)
        return label
    }()
    
    private lazy var logoIcon: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.16)
        view.layer.cornerRadius = 25
        
        view.addSubview(iconLetterLabel)
        iconLetterLabel.anchor()
        iconLetterLabel.centerX(inView: view)
        iconLetterLabel.centerY(inView: view)
        
        return view
    }()
    
    private lazy var breweryAverageLabel: UILabel = {
        let label = UILabel().setNormalLabel(text: "5,0", size: 14, color: .black)
        return label
    }()
    
    private lazy var rating: AARatingBar = {
        let rating = AARatingBar()
        rating.color = .mainYellowTint
        rating.maxValue = 5
        rating.value = 3.4
        
        return rating
    }()
    
    private lazy var breweryEvaluationView: UIView = {
        let view = UIView()
    
        view.addSubview(breweryAverageLabel)
        breweryAverageLabel.anchor()
        breweryAverageLabel.centerY(inView: view)
        
        view.addSubview(rating)
        rating.anchor(left: breweryAverageLabel.rightAnchor, paddingLeft: 4, width: 80, height: 80)
        rating.centerY(inView: view)
        
        return view
    }()
    
    private lazy var containerViewCell: UIView = {
        let view = UIView()
        
        layer.cornerRadius = 8
        backgroundColor = .white
        
        contentView.addSubview(logoIcon)
        logoIcon.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingBottom: 8
        )
        logoIcon.widthAnchor.constraint(equalToConstant: 48).isActive = true
        logoIcon.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        contentView.addSubview(breweryNameLabel)
        breweryNameLabel.anchor(
            top: contentView.topAnchor,
            left: logoIcon.rightAnchor,
            right: contentView.rightAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingRight: 8
        )
        
        contentView.addSubview(breweryEvaluationView)
        breweryEvaluationView.anchor(
            top: breweryNameLabel.bottomAnchor,
            left: logoIcon.rightAnchor,
            bottom: contentView.bottomAnchor,
            paddingTop: 2,
            paddingLeft: 8,
            paddingBottom: 12
        )
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layer.cornerRadius = 8
        backgroundColor = .white
        
        contentView.addSubview(logoIcon)
        logoIcon.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingBottom: 8
        )
        logoIcon.widthAnchor.constraint(equalToConstant: 48).isActive = true
        logoIcon.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        contentView.addSubview(breweryNameLabel)
        breweryNameLabel.anchor(
            top: contentView.topAnchor,
            left: logoIcon.rightAnchor,
            right: contentView.rightAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingRight: 8
        )
        
        contentView.addSubview(breweryEvaluationView)
        breweryEvaluationView.anchor(
            top: breweryNameLabel.bottomAnchor,
            left: logoIcon.rightAnchor,
            bottom: contentView.bottomAnchor,
            paddingTop: 2,
            paddingLeft: 8,
            paddingBottom: 12
        )
    }
    
    func setData(evaluatedBrewery: Brewery) {
        guard let character = evaluatedBrewery.name.first else { return }
        self.iconLetterLabel.text = String(describing: character)
        self.breweryNameLabel.text = evaluatedBrewery.name
        self.breweryAverageLabel.text = String(describing: evaluatedBrewery.average)
        self.rating.value = evaluatedBrewery.average.rounded(.down)
    }
}
