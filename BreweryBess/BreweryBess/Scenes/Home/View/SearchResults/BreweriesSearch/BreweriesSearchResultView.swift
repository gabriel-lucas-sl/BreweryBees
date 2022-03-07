//
//  SearchViewController.swift
//  BreweryBess
//
//  Created by Taila Nayara Saviani on 31/01/22.
//

import UIKit

protocol BreweriesSearchResultViewDelegate: AnyObject {
    func didSelectBrewery()
    func didClickFavorite(_ button: UIButton, cell: Int)
    func didiClickShere()
    func didClickSort()
}

class BreweriesSearchResultView: UIView {
    
    // MARK: IBOutlet
    @IBOutlet weak var searchResultCount: UILabel!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var sortLabel: UILabel!
    // MARK: Attributes
    
    var delegate: BreweriesSearchResultViewDelegate?
    var breweries: [Brewery] = []
    var selectCell: Int = 0
    
    // MARK: IBActions
    
    @IBAction func sortButton(_ sender: Any) {
        delegate?.didClickSort()
    }
    
    // MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
    }
    
    // MARK: Func
    
    func configureTableView() {
        searchResultTableView.register(UINib(nibName: "BreweryTableViewCell", bundle: nil), forCellReuseIdentifier: "BreweryTableViewCell")
    }
    
}

extension BreweriesSearchResultView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let breweryCell = tableView.dequeueReusableCell(withIdentifier: "BreweryTableViewCell") as? BreweryTableViewCell else {
            fatalError("Error to create BreweryTableviewCell")
        }
        let brewery = breweries[indexPath.row]
        breweryCell.rowId = indexPath.row
        breweryCell.delegate = self
        breweryCell.breweryNameLabel?.text = brewery.name
        breweryCell.firstLetterNameLabel?.text = String(brewery.name.prefix(1))
        breweryCell.breweryTypeLabel.text = brewery.brewery_type
        searchResultCount.text = String(describing: breweries.count)
        breweryCell.ratingLabel.text = String(describing: brewery.average)
        return breweryCell
    }
}

extension BreweriesSearchResultView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectCell = indexPath.row
        delegate?.didSelectBrewery()
    }
    
}

extension BreweriesSearchResultView: BreweryTableViewCellDelegate {
    
    func customCell(_ cell: BreweryTableViewCell, _ didTappedThe: UIButton?, _ buttonFunction: String) {
        
        buttonFunction == ButtonFunction.favorite.rawValue ? delegate?.didClickFavorite(didTappedThe ?? UIButton(), cell: cell.rowId) : delegate?.didiClickShere()

    }
    
}
