//
//  FavoritesBreweryViewController.swift
//  BreweryBess
//
//  Created by Taila Nayara Saviani on 07/02/22.
//

import UIKit
import RealmSwift

protocol FavoritesBreweryViewControllerDelegate: AnyObject {
    func didSelectBrewery(_ id: String)
    func didClickFavorite(_ id: String)
    func didiClickShere()
    func didClickSort()
}

class FavoritesBreweryViewController: UIViewController {
    
    // MARK: UIOutlets
    
    @IBOutlet weak var favoritesBreweryTableView: UITableView!
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var countFavoritesLabel: UILabel!
    private lazy var favoritesViewModel: FavoritesViewModel = AppContainer.shared.resolve(FavoritesViewModel.self)!
    var favorites: Results<Favorite>?
    
    // MARK: Attributes
    
    var delegate: FavoritesBreweryViewControllerDelegate?
    
    // MARK: UIActions
    
    @IBAction func sortButton(_ sender: Any) {
        delegate?.didClickSort()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: Func
    
    func configureTableView() {
        favoritesBreweryTableView.register(UINib(nibName: "BreweryTableViewCell", bundle: nil), forCellReuseIdentifier: "BreweryTableViewCell")
    }
    
}

extension FavoritesBreweryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites == nil {
            countFavoritesLabel.text = "0"
            return 0
        }
        
        countFavoritesLabel.text = "\(favorites!.count)"
        return favorites!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let breweryCell = tableView.dequeueReusableCell(withIdentifier: "BreweryTableViewCell") as? BreweryTableViewCell else {
            fatalError("Error to create BreweryTableviewCell")
        }
        
        let brewery = favorites![indexPath.row]
        breweryCell.breweryId = brewery.id
        breweryCell.breweryNameLabel?.text = brewery.name
        breweryCell.firstLetterNameLabel?.text = String(brewery.name.prefix(1))
        breweryCell.breweryTypeLabel?.text = brewery.brewery_type
        breweryCell.ratingLabel?.text = String(describing: brewery.average)
        breweryCell.favoriteButton.setImage(UIImage(named: "favorited.png"), for: .normal)
        breweryCell.delegate = self
        return breweryCell
    }
}

extension FavoritesBreweryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectBrewery(favorites![indexPath.row].id)
    }
}

extension FavoritesBreweryViewController: BreweryTableViewCellDelegate {
    func customCell(_ cell: BreweryTableViewCell, _ didTappedThe: UIButton?, _ buttonFunction: String) {
        buttonFunction == ButtonFunction.favorite.rawValue ? delegate?.didClickFavorite(cell.breweryId) : delegate?.didiClickShere()
    }
}
