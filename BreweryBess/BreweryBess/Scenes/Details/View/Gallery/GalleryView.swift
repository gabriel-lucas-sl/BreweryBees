//
//  GalleryView.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 07/02/22.
//

import UIKit
import SDWebImage

protocol GalleryProtocol {
    func didClickedEvaluateBreweryButton()
    func didPressAddPhotoButton()
}

class GalleryView: UIView {
    
    // MARK: Attributes
    
    var delegate: GalleryProtocol?
    var breweryPhotos: [Any] = []
    
    // MARK: IBOutlet
    
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var galleryPageControl: UIPageControl!
    
    // MARK: IBAction
    
    @IBAction func evaluateBrewery(_ sender: UIButton) {
        delegate?.didClickedEvaluateBreweryButton()
    }
    
    @IBAction func addPhotoButton(_ sender: UIButton) {
        delegate?.didPressAddPhotoButton()
    }
    
    override func awakeFromNib() {
        addPhotoButton.layer.borderWidth = 1
        addPhotoButton.layer.cornerRadius = 4
        galleryCollection.register(UINib(nibName: "BreweryPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        galleryCollection.dataSource = self
        galleryCollection.delegate = self
    }
}

extension GalleryView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.8, height: collectionView.frame.width/3.8)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breweryPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? BreweryPhotoCollectionViewCell
        else { fatalError() }
        
        if type(of: breweryPhotos[indexPath.row]) == UIImage.self {
            if let image = breweryPhotos[indexPath.row] as? UIImage {
                cell.breweryImage.image = image
            }
        } else {
            cell.breweryImage.sd_setImage(with: URL(string: String(describing: breweryPhotos[indexPath.row])),
                                          placeholderImage: UIImage(named: "default-image.png"),
                                          completed: { _, downloadException, _, _ in
                                              if let downloadException = downloadException {
                                                  print("\nError downloading the image: \(downloadException.localizedDescription)\n")
                                              }
                                      })
        }

        cell.layer.cornerRadius = 4
        return cell
    }
}
