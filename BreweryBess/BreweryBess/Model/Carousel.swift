//
//  CarouselData.swift
//  BreweryBess
//
//  Created by Gabriel Ferro Roque Fontes on 07/02/22.
//

import Foundation
import UIKit
import SDWebImage

public struct Carousel {
    public var id: String
    public var name: String
    public var image: String?
    public var score: String
    public var type: String
    public var distance: String?
    
    public init(id: String, name: String, image: String?, score: String, type: String, distance: Any? = 0) {
        self.id = id
        self.name = name
        self.image = image
        self.score = score
        self.type = type
    }
    
    func fetchImage(imageView: UIImageView) -> UIImage {
        var image: UIImage?
        guard let defaultImage = UIImage(named: "NoImgIcon") else { return UIImage() }
        guard let imageUrl = self.image else { return defaultImage }
        
        imageView.sd_setImage(
            with: URL(string: imageUrl),
            placeholderImage: defaultImage,
            options: SDWebImageOptions.highPriority,
            context: nil, progress: nil,
            completed: { downloadedImage, downloadException, cacheType, downloadURL in
                if let downloadException = downloadException {
                    print("\nError downloading the image: \(downloadException.localizedDescription)\n")
                    
                } else {
                    print("Successfully downloaded the image")
                    image = downloadedImage
                    imageView.contentMode = .scaleAspectFill
                }
        })

        return image ?? defaultImage
    }
}
