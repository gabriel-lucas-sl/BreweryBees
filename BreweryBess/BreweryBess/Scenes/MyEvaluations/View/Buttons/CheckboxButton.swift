//
//  CheckboxButton.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 01/03/22.
//

import UIKit

class CheckboxButton: UIButton {

    let checkedImage = K.Images.checkbox_fill

    var isChecked: Bool = true {
        didSet {
            if isChecked {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(K.Images.checkbox_empty, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(CheckboxButton.handlePressButton(sender:)), for: .touchUpInside)
        self.setImage(checkedImage, for: .normal)
        self.anchor(width: 18, height: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePressButton(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
