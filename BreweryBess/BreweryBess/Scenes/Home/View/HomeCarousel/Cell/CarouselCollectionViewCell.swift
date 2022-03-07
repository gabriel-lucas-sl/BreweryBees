//
//  CarouselCollectionViewCell.swift
//  BreweryBess
//
//  Created by Gabriel Ferro Roque Fontes on 01/02/22.
//

import UIKit
import SDWebImage

class CarouselCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var breweryLabel: UILabel!
    @IBOutlet weak var breweryImage: UIImageView!
    @IBOutlet weak var breweryRateLabel: UILabel!
    @IBOutlet weak var breweryTypeLabel: UILabel!
    @IBOutlet weak var breweryDistanceLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    
    static let cellID = "CarouselCell"
    var labelText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(data carouselData: Carousel) {
        breweryImage.contentMode = .center
        breweryImage.image = carouselData.fetchImage(imageView: breweryImage)
        breweryImage.clipsToBounds = true
        breweryLabel.text = carouselData.name
        breweryTypeLabel.text = carouselData.type
        breweryRateLabel.text = carouselData.score
        breweryDistanceLabel.text = carouselData.distance
    
    }
}
