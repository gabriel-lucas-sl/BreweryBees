//
//  SheetBreweryReviewViewController.swift
//  BreweryBess
//
//  Created by Jose Mateus Azevedo de Sousa on 01/02/22.
//

import UIKit

protocol SheetBreweryReviewViewControllerDelegate: AnyObject {
    func reloadGallery()
}

class SheetBreweryReviewViewController: UIViewController {
    
    private lazy var viewModel: SheetBreweryReviewViewModel = AppContainer.shared.resolve(SheetBreweryReviewViewModel.self)!
    var breweryId: String = ""
    
    var delegate: SheetBreweryReviewViewControllerDelegate?
    
    var currentRating: CGFloat?

    lazy var contentView: SheetBreweryReviewView = {
        let view = SheetBreweryReviewView()
        return view
    }()

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.saveButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        contentView.addGestureRecognizer(tap)
        
        contentView.rating.ratingDidChange = { [self] ratingValue in
            contentView.ratingValue = ratingValue
        }
    }
    
    @objc func pressed() {
        
        let userEmail = contentView.emailTextField.text ?? ""
        let rating = contentView.ratingValue
        
        viewModel.onShowFeedback = { statusCode in
            DispatchQueue.main.async {
                if statusCode == 201 {
                    self.contentView.addSubview(FeedbackBreweryReviewView(frame: self.contentView.frame))
                    let evaluation = Evaluation()
                    evaluation.brewery_id = self.breweryId
                    evaluation.email = userEmail
                    evaluation.rating = rating
                    self.viewModel.breweryRepository.saveEvaluation(evaluation)
                    self.delegate?.reloadGallery()
                } else {
                    self.contentView.addSubview(FeedbackBreweryReviewView(frame: self.contentView.frame, type: 2))
                }
            }
        }
        viewModel.brewery = BreweryEvaluation(email: userEmail, id: breweryId, evaluate: rating)
        viewModel.evaluateBrewery()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
