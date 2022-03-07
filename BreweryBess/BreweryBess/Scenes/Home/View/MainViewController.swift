//
//  ViewController.swift
//  BreweryBess
//
//  Created by Francisco Santana Cardoso on 28/01/22.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Attributes
    var searchText: String?
    var listOrder: OrdenationBreweryType = .evaluetion
    var breweryId: String = ""
    
    private lazy var searchViewModel: SearchViewModel = AppContainer.shared.resolve(SearchViewModel.self)!
    
    lazy var brewerySearchResultView = Bundle.main.loadNibNamed("BreweriesSearchResultView", owner: self, options: nil)?.first as? BreweriesSearchResultView
    lazy var carouselView = Bundle.main.loadNibNamed("CarouselView", owner: self, options: nil)?.first as? CarouselView
    lazy var errorView = Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)?.first as? ErrorView
    
    // MARK: IBOutlet
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var homeContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTextfield()
        brewerySearchResultView?.delegate = self
        carouselView?.delegate = self
        homeContainer.addSubview(self.carouselView!)
    }
    
    @IBAction func clickFavoritos(_ sender: Any) {
        self.performSegue(withIdentifier: "FavoritesViewController", sender: self)
    }
    
    @IBAction func clickMyEvaluations(_ sender: UIBarButtonItem) {
        let controller = MyEvaluationsView()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func imageTextfield() {
        let imageview = UIImageView(frame: CGRect(x: 16, y: 8, width: 23, height: 23))
        let image = UIImage(named: "lupa")
        imageview.image = image
        imageview.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(imageview)
        textFieldSearch?.leftViewMode = .always
        textFieldSearch?.leftView = view
    }
    
}

extension MainViewController: BreweriesSearchResultViewDelegate {
    
    func didSelectBrewery() {
        self.breweryId = self.searchViewModel.listOrder[self.brewerySearchResultView?.selectCell ?? 0].id
        let detailsViewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        detailsViewController?.selectBreweryId = self.breweryId
        navigationController?.pushViewController(detailsViewController ?? DetailsViewController(), animated: true)
    }
    
    func didClickFavorite(_ button: UIButton, cell: Int) {
        let favorite = Favorite()
        favorite.id = self.searchViewModel.listOrder[cell].id
        favorite.name = self.searchViewModel.listOrder[cell].name
        favorite.brewery_type = self.searchViewModel.listOrder[cell].brewery_type
        favorite.average = self.searchViewModel.listOrder[cell].average
        self.searchViewModel.savefavorite(favorite: favorite)
        button.setImage(UIImage(named: "favorited.png"), for: .normal)
    }
    
    func didiClickShere() {
        print("Compartilhar")
    }
    
    func didClickSort() {
        
        if self.listOrder == .evaluetion {
            self.listOrder = .alphabetic
        } else {
            self.listOrder = .evaluetion
        }
        
        brewerySearchResultView?.sortLabel.text = listOrder.rawValue
        
        searchViewModel.searchResultReorder = { breweries in
            DispatchQueue.main.async {
                self.brewerySearchResultView?.breweries = breweries
                self.brewerySearchResultView?.frame = self.homeContainer.frame
                self.homeContainer.addSubview(self.brewerySearchResultView!)
                
                self.brewerySearchResultView?.searchResultTableView.reloadData()
           }
        }
        
        self.searchViewModel.reorder(Order: self.listOrder)
    }
    
}

extension MainViewController: TopTenCarouselDelegate {
    func handleTap(breweryId: String) {
        let detailsViewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        detailsViewController?.selectBreweryId = breweryId
        navigationController?.pushViewController(detailsViewController ?? DetailsViewController(), animated: true)
    }
}

// MARK: search Result
extension MainViewController {
    
    func setErrorType (error: ErrorTitle) {
        self.errorView?.frame = self.homeContainer.frame
        self.errorView?.setErrorType(error)
        self.homeContainer.addSubview(self.errorView!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.searchText = textField.text?.trimmingCharacters(in: .whitespaces).addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        searchViewModel.searchResult = { breweries, statusCode in

            DispatchQueue.main.async {
                if self.searchText?.isEmpty == true || statusCode == 400 {
                    self.setErrorType(error: .searchTextError)
                } else {
                    switch statusCode {
                    case 404, 500:
                        self.setErrorType(error: .resultError)
                    case 200:
                        self.brewerySearchResultView?.sortLabel.text = self.listOrder.rawValue
                        self.brewerySearchResultView?.breweries = breweries
                        self.brewerySearchResultView?.frame = self.homeContainer.frame
                        self.homeContainer.addSubview(self.brewerySearchResultView!)
                    default:
                        break
                    }
                }
                self.brewerySearchResultView?.searchResultTableView.reloadData()
            }
        }
        searchViewModel.search(city: self.searchText ?? "")
        
        textField.resignFirstResponder()
        return true
    }
}
