//
//  favoritesViewController.swift
//  BreweryBess
//
//  Created by Francisco Santana Cardoso on 03/02/22.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var favoritesContainer: UIView!
    private lazy var favoritesViewModel: FavoritesViewModel = AppContainer.shared.resolve(FavoritesViewModel.self)!
    var sort: FavoritesOrder = .name
    let favoritesBreweryViewController = FavoritesBreweryViewController()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        super.viewDidLoad()
        loadData(sort)
    }
    
    func loadData(_ sort: FavoritesOrder) {
        self.favoritesViewModel.favoritesResult = { favorites in
            DispatchQueue.main.async {
                self.favoritesBreweryViewController.favorites = favorites
                self.favoritesBreweryViewController.view.frame = self.favoritesContainer.frame
                self.favoritesContainer.addSubview(self.favoritesBreweryViewController.view)
                self.favoritesBreweryViewController.delegate = self
                self.favoritesBreweryViewController.favoritesBreweryTableView.reloadData()
            }
        }
        
        self.favoritesViewModel.list(sort)
    }
}

extension FavoritesViewController: FavoritesBreweryViewControllerDelegate {
    func didSelectBrewery(_ id: String) {
        let detailsViewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        detailsViewController?.selectBreweryId = id
        navigationController?.pushViewController(detailsViewController ?? DetailsViewController(), animated: true)
    }
    
    func didClickFavorite(_ id: String) {
        self.favoritesViewModel.delete(id)
        loadData(sort)
    }
    
    func didiClickShere() {
        print("Compartilhar")
    }
    
    func didClickSort() {
        if sort == .average {
            sort = .name
            loadData(.name)
        } else {
            sort = .average
            loadData(.average)
        }
        
        self.favoritesBreweryViewController.sortLabel.text = sort.rawValue
    }
}
