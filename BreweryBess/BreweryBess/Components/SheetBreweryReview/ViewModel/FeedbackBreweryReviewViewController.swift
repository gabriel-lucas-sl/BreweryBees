//
//  FeedbackBreweryReviewViewController.swift
//  BreweryBess
//
//  Created by Jose Mateus Azevedo de Sousa on 04/02/22.
//

import UIKit

class FeedbackBreweryReviewViewController: UIViewController {

    lazy var contentView: FeedbackBreweryReviewView = {
        let view = FeedbackBreweryReviewView()
        return view
    }()

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
