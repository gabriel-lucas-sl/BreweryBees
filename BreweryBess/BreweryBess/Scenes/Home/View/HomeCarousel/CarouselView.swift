//
//  CarouselView.swift
//  BreweryBess
//
//  Created by Gabriel Ferro Roque Fontes on 01/02/22.
//
import UIKit

protocol TopTenCarouselDelegate: AnyObject {
    func handleTap(breweryId: String)
}

class CarouselView: UIView {
    @IBOutlet weak var breweryCarousel: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var carouselPageControl: UIPageControl!
    
    var delegate: TopTenCarouselDelegate?
    var carouselViewModel: CarouselViewModel = AppContainer.shared.resolve(CarouselViewModel.self)!
    var carouselData: [Carousel] = [Carousel]()
    var shownCards: Int = 0
    var currentPage = 0 {
        didSet {
            carouselPageControl.currentPage = currentPage
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        breweryCarousel.delegate = self
        breweryCarousel.dataSource = self
        breweryCarousel.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CarouselCollectionViewCell.cellID)
        
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        fetchCarouselBreweries()
        configureView()
    }

    func fetchCarouselBreweries() {
        carouselViewModel.onShowTopTen = { breweries in
            DispatchQueue.main.async {
                self.carouselData = breweries.map { brewery in
                    return Carousel(id: brewery.id, name: brewery.name, image: brewery.photos?.first, score: String(brewery.average), type: brewery.brewery_type)
                }
                self.spinner.stopAnimating()
                self.breweryCarousel.reloadData()
            }
        }
        
        carouselViewModel.fetchTopTenCarousel()
    }
}

// MARK: - UICollectionViewDataSourceSection
extension CarouselView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.cellID,
                                                            for: indexPath) as? CarouselCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        if indexPath.row == 1 {
            let numbOfPages = calcNumbOfPages(cellFrameWidth: Int(cell.frame.size.width), collectionViewFrameWidth: Int(collectionView.frame.size.width))
            carouselPageControl.size(forNumberOfPages: numbOfPages)
            carouselPageControl.numberOfPages = numbOfPages
        }

        cell.layer.cornerRadius = 8
        cell.configure(data: carouselData[indexPath.row])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.handleTap(breweryId: carouselData[indexPath.row].id)
    }
    
    private func calcNumbOfPages(cellFrameWidth: Int, collectionViewFrameWidth: Int) -> Int {
        shownCards = (cellFrameWidth + 12) * carouselData.count / collectionViewFrameWidth
        let numPages = Double(Double(carouselData.count) / Double(shownCards))
        return Int(numPages.rounded(.up))
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

// MARK: - CarouselViewStylesSetupSection
extension CarouselView {
    
    public func configureView() {
        let cellPadding = (frame.width - 300) / 2
        let carouselLayout = UICollectionViewFlowLayout()

        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 140, height: 234)
        carouselLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: cellPadding - 10)
        carouselLayout.minimumLineSpacing = 12

        carouselPageControl.translatesAutoresizingMaskIntoConstraints = false
        carouselPageControl.topAnchor.constraint(equalTo: breweryCarousel.bottomAnchor, constant: 20).isActive = true
        carouselPageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        carouselPageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        carouselPageControl.pageIndicatorTintColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)

        breweryCarousel.isPagingEnabled = true
        breweryCarousel.collectionViewLayout = carouselLayout
        breweryCarousel.reloadData()
    }

    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: breweryCarousel.contentOffset, size: breweryCarousel.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        if let visibleIndexPath = breweryCarousel.indexPathForItem(at: visiblePoint) {
            let cardElement = carouselData[visibleIndexPath.row]
            return calcCurrentPage(currentCard: cardElement)
        }

        return currentPage
    }

    private func calcCurrentPage(currentCard: Carousel) -> Int {
        var page: Int = currentPage
        var fullPages = [[Carousel]]()
        var tempElements: [Carousel] = []
        for element in carouselData {
            tempElements.append(element)
            if tempElements.count == shownCards {
                fullPages += [tempElements]
                tempElements = []
            }
        }

        for (index, element) in fullPages.enumerated() {
            if element.contains(where: { $0.name == currentCard.name }) {
                page = index
            }
        }
        return page
    }
}
