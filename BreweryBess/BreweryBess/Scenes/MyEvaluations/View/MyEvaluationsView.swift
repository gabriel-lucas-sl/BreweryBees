//
//  MyEvaluations.swift
//  BreweryBess
//
//  Created by Gabriel Lucas Alves da Silva on 28/02/22.
//

import UIKit
import RxSwift

class MyEvaluationsView: UIViewController {
    
    var timer = Timer()
    var evaluations: [Brewery] = []
    let defaults = UserDefaults.standard
    var shouldLoadNoEvaluationsView: Bool = false
    var shouldRememberEmail: Bool = true
    let myEvaluationsViewModel: MyEvaluationsViewModel = AppContainer.shared.resolve(MyEvaluationsViewModel.self)!
    let myEvaluationsTableView: MyEvaluationsTableView = AppContainer.shared.resolve(MyEvaluationsTableView.self)!
    
    // MARK: - Properties
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TopBackground")
        guard let image = imageView.image else { return UIImageView() }
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let text = "Cervejarias que você avaliou"
        let label = UILabel().setBoldLabel(text: text, size: 20, color: .black)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let text = "Você ainda não avaliou nenhuma cervejaria. Suas cervejarias avaliadas aparecerão aqui."
        let label = UILabel().setNormalLabel(text: text, size: 16, color: .black)
        label.numberOfLines = 5
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.textColor = .black
        tf.autocapitalizationType = .none
        tf.font = UIFont(name: "Quicksand", size: 16)
        tf.attributedPlaceholder = NSAttributedString(
            string: "nome@email.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        return tf
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    
    private lazy var checkboxButton: CheckboxButton = {
        let button = CheckboxButton(type: .custom)
        button.addTarget(self, action: #selector(checkToRememberEmail), for: .touchUpInside)
        return button
    }()
    
    private let checkboxLabel: UILabel = {
        let text = "Lembrar meu e-mail para futuras consultas"
        let label = UILabel().setNormalLabel(text: text, size: 16, color: .black)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var confirmButton: ConfirmEmailButton = {
        var button = ConfirmEmailButton(type: .system)
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 16)
        button.isEnabled = false
        button.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.3)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.3), for: .normal)
        button.addTarget(self, action: #selector(handlePressConfirmButton), for: .touchUpInside)
        return button
    }()

    // MARK: - LifecycleSession
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        verifyIfThereIsSavedEmail()
        settingBackButton()
        
        if !shouldLoadNoEvaluationsView {
            timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(getUserTextField), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        print("Stopped timer!")
    }
    
    // MARK: - SelectorsSession
    @objc func back(sender: UIBarButtonItem) {
        if shouldLoadNoEvaluationsView {
            shouldLoadNoEvaluationsView = false
            timer.invalidate()
            loadView()
            viewDidLoad()
            
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handlePressConfirmButton() {
        guard let email = emailTextField.text else { return }

        if shouldRememberEmail {
            saveEmail(for: email)
        } else {
            defaults.removeObject(forKey: "EMAIL")
        }

        myEvaluationsViewModel.onShowMyEvaluations = { breweries, _ in
            DispatchQueue.main.async {
                if !breweries.isEmpty {
                    self.myEvaluationsTableView.evaluations.append(contentsOf: breweries)
                    self.myEvaluationsTableView.evaluationsTableView.reloadData()
                    self.navigationController?.pushViewController(self.myEvaluationsTableView, animated: true)
                } else {
                    self.shouldLoadNoEvaluationsView = true
                    self.loadView()
                    self.viewDidLoad()
                }
            }
        }
        
        myEvaluationsViewModel.fetchMyEvaluation(for: email)
    }
    
    @objc func checkToRememberEmail() {
        shouldRememberEmail = !shouldRememberEmail
        return
    }
    
    // MARK: - HelpersSession
    
    func settingBackButton() {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(MyEvaluationsView.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    func verifyIfThereIsSavedEmail() {
        let email = defaults.string(forKey: "EMAIL")
        if let safeEmail = email {
            emailTextField.text = safeEmail
        }
    }
    
    func saveEmail(for email: String) {
        defaults.set(email, forKey: "EMAIL")
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @objc func getUserTextField() {
        print("Timer is running...")
        let input = emailTextField.text
        let isEmailValid = validateEmail(email: input ?? "")
        
        if isEmailValid {
            confirmButton.isEnabled = true
            confirmButton.backgroundColor = .mainYellowTint
            confirmButton.setTitleColor(.black, for: .normal)
            
            return
        }
        
        confirmButton.isEnabled = false
        confirmButton.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.3)
        confirmButton.isEnabled = false
        confirmButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.3), for: .normal)
    }
    
    func configureUI() {
        self.title = "Cervejarias avaliadas"
        view.backgroundColor = .backgroundColor
        
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 0,
                               paddingLeft: 0,
                               paddingRight: 0)
        
        if shouldLoadNoEvaluationsView {
            timer.invalidate()
            return loadNoEvaluationsView()
        }
        
        let headerStack = UIStackView(arrangedSubviews: [titleLabel,
                                                         subtitleLabel])
        headerStack.axis = .vertical
        headerStack.spacing = 12
        
        view.addSubview(headerStack)
        headerStack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(
            top: headerStack.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 95,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        let checkboxStack = UIStackView(arrangedSubviews: [checkboxButton, checkboxLabel])
        checkboxStack.axis = .horizontal
        checkboxStack.spacing = 4
        
        view.addSubview(checkboxStack)
        checkboxStack.anchor(
            top: emailContainerView.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        view.addSubview(confirmButton)
        confirmButton.anchor(
            top: checkboxStack.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 28,
            paddingLeft: 16,
            paddingRight: 16
        )
    }
    
    func loadNoEvaluationsView() {
        let noEvaluationView = NoEvaluationsView()
        view.addSubview(noEvaluationView)
        noEvaluationView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 28,
            paddingLeft: 32,
            paddingRight: 32
        )
    }
}
