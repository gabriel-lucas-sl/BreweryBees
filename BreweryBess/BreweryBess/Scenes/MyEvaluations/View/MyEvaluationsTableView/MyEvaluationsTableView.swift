//
//  MyEvaluationsTableView.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 01/03/22.
//

import UIKit

class MyEvaluationsTableView: UIViewController {
    
    var myEvaluationsViewModel: MyEvaluationsViewModel = AppContainer.shared.resolve(MyEvaluationsViewModel.self)!
    var evaluations: [Brewery] = []
    
    // MARK: - PropertiesSessions
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TopBackground")
        guard let image = imageView.image else { return UIImageView() }
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel().setBoldLabel(text: "Cervejarias que você avaliou", size: 18, color: .black)
        
        if let labelText = label.text {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(1.0), range: NSRange(location: 0, length: attributedString.length))
            label.attributedText = attributedString
        }
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel().setNormalLabel(text: "", size: 14, color: .black)
        return label
    }()
    
    private let tableViewLabel: UILabel = {
        let label = UILabel().setNormalLabel(text: "Ordernar por: Nota", size: 14, color: .black)
        return label
    }()
    
    private lazy var sortIcon: UIButton = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sort")
        guard let image = imageView.image else { return UIButton() }
        
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.layer.borderWidth = 0
        button.addTarget(self, action: #selector(handleSortTable), for: .touchUpInside)
        
        return button
    }()
    
    lazy var evaluationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(MyEvaluationsTableViewCell.self, forCellReuseIdentifier: K.MyEvaluations.tableCellIdentifier)
        return tableView
    }()

    // MARK: - InitializersSession
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        evaluationsTableView.delegate = self
        evaluationsTableView.dataSource = self
    }
    
    // MARK: - SelectorsSession
    
    @objc func handleSortTable() {
        print("Sorting table...")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        self.title = "Cervejarias avaliadas"
        view.backgroundColor = .backgroundColor
        subTitleLabel.text = "\(evaluations.count) resultados"
        evaluationsTableView.separatorStyle = .none
        
        view.addSubview(backgroundImage)
        backgroundImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingRight: 0
        )
        
        view.addSubview(titleLabel)
        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingRight: 16
        )

        view.addSubview(subTitleLabel)
        subTitleLabel.anchor(
            top: titleLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 4,
            paddingLeft: 16,
            paddingRight: 16
        )

        let stackForTableViewLabels = UIStackView(arrangedSubviews: [tableViewLabel, sortIcon])
        stackForTableViewLabels.axis = .horizontal
        stackForTableViewLabels.distribution = .fill

        view.addSubview(stackForTableViewLabels)
        stackForTableViewLabels.anchor(
            top: subTitleLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingRight: 16
        )

        view.addSubview(evaluationsTableView)
        evaluationsTableView.translatesAutoresizingMaskIntoConstraints = false
        evaluationsTableView.topAnchor.constraint(equalTo: stackForTableViewLabels.bottomAnchor, constant: 12).isActive = true
        evaluationsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        evaluationsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        evaluationsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDelegateSession

extension MyEvaluationsTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.evaluations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
         
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.MyEvaluations.tableCellIdentifier) as? MyEvaluationsTableViewCell else {
            fatalError("Error to create MyEvaluationsTableViewCell")
        }

        cell.setData(evaluatedBrewery: evaluations[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = evaluations[indexPath.section]
        let detailsViewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        detailsViewController?.selectBreweryId = cell.id
        navigationController?.pushViewController(detailsViewController ?? DetailsViewController(), animated: true)
    }
}
