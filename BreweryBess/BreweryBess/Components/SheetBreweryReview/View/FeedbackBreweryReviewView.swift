//
//  FeedbackBreweryReviewView.swift
//  BreweryBess
//
//  Created by Jose Mateus Azevedo de Sousa on 02/02/22.
//

import UIKit

class FeedbackBreweryReviewView: UIView {

    private var feedbackType: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
        setConstraints()
    }
    
    required init(frame: CGRect, type: Int) {
        super.init(frame: frame)
        feedbackType = type
        backgroundColor = .white
        addViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if feedbackType == 1 {
            label.text = "Um brinde!"
        } else {
            label.text = "Algo de errado!"
        }
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Quicksand-Bold", size: 22)
       
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        if feedbackType == 1 {
            image.image = UIImage(named: "feedback_ok")
        } else {
            image.image = UIImage(named: "feedback_failure")
        }
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
       
        return image
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if feedbackType == 1 {
            label.text = "Sua avaliação foi realizada com sucesso!"
            label.textColor = .systemGreen
        } else {
            label.text = "Não foi possivel adicionar sua avaliação.\nTente mais tarde."
            label.textColor = .systemRed
        }
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Quicksand-Regular", size: 16)
       
        return label
    }()
    
    func addViews() {
        self.addSubview(titleLabel)
        self.addSubview(imageView)
        self.addSubview(descriptionLabel)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            imageView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
