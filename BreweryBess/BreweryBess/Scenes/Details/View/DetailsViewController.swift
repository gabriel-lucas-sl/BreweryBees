//
//  DetailsViewController.swift
//  BreweryBess
//
//  Created by Francisco Santana Cardoso on 03/02/22.
//

import UIKit
import AARatingBar
import PhotosUI

class DetailsViewController: UIViewController {
 
    // MARK: Attributes

    private lazy var breweryDetailsViewModel: BreweryDetailsViewModel = AppContainer.shared.resolve(BreweryDetailsViewModel.self)!
    private lazy var breweryDB: BreweryDBProtocol = AppContainer.shared.resolve(BreweryDBProtocol.self)!
    private lazy var sheetViewController = SheetBreweryReviewViewController()

    var breweryGallery: GalleryView?
    var selectBreweryId: String?
    var isBreweryAlready = true
    
    // MARK: IBOutlets

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var breweryLogo: UILabel!
    @IBOutlet weak var breweryName: UILabel!
    @IBOutlet weak var breweryType: UILabel!
    @IBOutlet weak var breweryEvaluation: UILabel!
    @IBOutlet weak var evaluationsQuantify: UILabel!
    @IBOutlet weak var breweryWebsite: UILabel!
    @IBOutlet weak var breweryAddress: UILabel!
    @IBOutlet weak var galleryContainer: UIView!
    @IBOutlet weak var ratingBarView: AARatingBar!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        super.viewDidLoad()
        container.layer.cornerRadius = 15
        breweryGallery = getGalleryView()
        loadGallery()
    
    }
    
    func loadGallery() {
        let view = isBreweryAlreadyEvaluated()
        galleryContainer.addSubview(view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        breweryDetailsViewModel.onShowDetails = { brewery in
            DispatchQueue.main.async {
                self.setBreweryDetails(brewery)
                self.breweryGallery?.breweryPhotos = brewery.photos ?? []
                self.breweryGallery?.galleryCollection.reloadData()
            }
        }
        breweryDetailsViewModel.onShowError = { errorRequest in
            DispatchQueue.main.async {
                print(errorRequest)
                self.navigationController?.popViewController(animated: true)
            }
        }
        breweryDetailsViewModel.fetchBreweryDetails(selectBreweryId ?? "")
    }
    
    // MARK: Functions
    
    private func isBreweryAlreadyEvaluated() -> UIView {
    
        if breweryDB.getEvaluated(selectBreweryId ?? "") != nil {
            guard let breweryEvaluated = Bundle.main.loadNibNamed("BreweryEvaluatedView", owner: self, options: nil)?.first as? BreweryEvaluatedView else { return UIView() }
            breweryEvaluated.frame = self.galleryContainer.frame
            return breweryEvaluated
        } else {
            breweryGallery?.frame = self.galleryContainer.frame
            breweryGallery?.delegate = self
            return breweryGallery ?? GalleryView()
        }
    }
    
    private func setBreweryDetails(_ brewery: Brewery) {
        breweryName.text = brewery.name
        breweryType.text = brewery.brewery_type
        breweryEvaluation.text = String(brewery.average)
        evaluationsQuantify.text = String(brewery.size_evaluations)
        breweryWebsite.text = brewery.website_url
        breweryAddress.text = getFullAddress(brewery)
        breweryLogo.text = String(brewery.name.prefix(1)).uppercased()
        ratingBarView.value = brewery.average

    }
    
    private func getFullAddress(_ brewery: Brewery) -> String {
        
        var street = String()
        var state = String()
        street = street.isEmpty ? "" : "\(street),"
        state = state.isEmpty ? "" : "\(state),"

        return "\(street) \(brewery.city) \(state), \(brewery.postal_code), \(brewery.country)"

    }
    
    private func getGalleryView() -> GalleryView {
        return Bundle.main.loadNibNamed("GalleryView", owner: self, options: nil)?.first as? GalleryView ?? GalleryView()
    }
}

extension DetailsViewController: GalleryProtocol {
    func didPressAddPhotoButton() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1

        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    
    func didClickedEvaluateBreweryButton
    () {
        sheetViewController.delegate = self
        sheetViewController.breweryId = selectBreweryId ?? ""
        
        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        
        present(sheetViewController, animated: true, completion: nil)
    }
}

extension DetailsViewController: SheetBreweryReviewViewControllerDelegate {
    func reloadGallery() {
        loadGallery()
    }
}

extension DetailsViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        if !results.isEmpty {
            let result = results.first!
            let itemProvider = result.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                    guard let image = image as? UIImage else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.breweryGallery?.galleryCollection.performBatchUpdates({
                            guard let photos = self.breweryGallery?.breweryPhotos else { return }
                            let indexPath = IndexPath(row: photos.count, section: 0)
                            self.breweryGallery?.breweryPhotos.append(image)
                            self.breweryGallery?.galleryCollection.insertItems(at: [indexPath])
                        }, completion: nil)
                        
                        self.breweryGallery?.galleryCollection.reloadData()
                    }
                    
                }
            }
        }
    }
}
