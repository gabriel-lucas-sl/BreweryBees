//
//  TakeBreweryReviewView.swift
//  BreweryBess
//
//  Created by Jose Mateus Azevedo de Sousa on 03/02/22.
//

import UIKit
import AARatingBar

class TakeBreweryReviewView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Quicksand-Bold", size: 20)
       
        return label
    }()
    
    lazy var rating: UIView = {
        let view = AARatingBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .systemYellow
        view.maxValue = 5
        view.value = 2
        
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = .systemGray
        textField.placeholder = "nome@email.com"
        textField.borderStyle = .roundedRect

        return textField
    }()
    
    lazy var erroLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Insira um email válido"
        label.textColor = .systemRed
        label.textAlignment = .left
        label.font = UIFont(name: "Quicksand-Regular", size: 14)
       
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemYellow
        button.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 16)
       
        return button
    }()
    
    func addViews() {
        self.addSubview(titleLabel)
        self.addSubview(rating)
        self.addSubview(emailTextField)
        self.addSubview(erroLabel)
        self.addSubview(saveButton)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rating.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            rating.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            rating.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -78),
            rating.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 78)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            emailTextField.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            erroLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4),
            erroLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            erroLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -28),
            saveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
}
