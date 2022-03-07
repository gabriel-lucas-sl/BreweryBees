//
//  BreweryTableViewCell.swift
//  BreweryBess
//
//  Created by Taila Nayara Saviani on 02/02/22.
//

import UIKit

protocol BreweryTableViewCellDelegate: AnyObject {

    func customCell(_ cell: BreweryTableViewCell, _ didTappedThe: UIButton?, _ buttonFunction: String)
}

enum ButtonFunction: String {
    case share
    case favorite
}

class BreweryTableViewCell: UITableViewCell {
    
    // MARK: Attributes
    
    var delegate: BreweryTableViewCellDelegate?

    // MARK: IBOutlet
    
    @IBOutlet weak var shereButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var firstLetterNameLabel: UILabel!
    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var breweryTypeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    var breweryId: String = ""
    var rowId: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: IBActions
    
    @IBAction func shereButtonAction(_ sender: Any) {
        delegate?.customCell(self, sender as? UIButton, ButtonFunction.share.rawValue)
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        delegate?.customCell(self, sender as? UIButton, ButtonFunction.favorite.rawValue)
    }
    
}
