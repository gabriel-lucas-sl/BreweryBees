//
//  MyEvaluationsViewTests.swift
//  BreweryBessTests
//
//  Created by Gabriel Lucas Alves da Silva on 04/03/22.
//

import XCTest
@testable import BreweryBess

class MyEvaluationsViewTests: XCTestCase {

    func test_configureUI_method_is_called() {
//        given the user access the my evaluations view
//        when the view did load
//        then call configureUI()
    }
    
    func test_verifyIfThereIsSavedEmail_method_is_called() {
//        given the user access the my evaluations view
//        when the view did load
//        then verifyIfThereIsSavedEmail
    }
    
    func test_givenTheUserProvideAnInvalidEmailWhenPressingConfirmThenTheButtonShouldntBeEnable() {
        let view = MyEvaluationsView()
        view.viewDidLoad()
        view.emailTextField.text = "invalid_email@gmail"
        
        XCTAssertFalse(view.confirmButton.isEnabled)
    }
    
    func test_givenTheUserProvideAValidEmailWhenPressingConfirmThenTheButtonShouldBeEnable() {
        let view = MyEvaluationsView()
        view.viewDidLoad()
        view.emailTextField.text = "valid_email@gmail.com"
        
        let timer = Timer(timeInterval: 0.8, target: self, selector: #selector(view.getUserTextField), userInfo: nil, repeats: true)
        
        XCTAssertTrue(view.confirmButton.isEnabled)
    }
    
    func test_givenTheUserAllowToRemeberItsEmailWhenPressingTheRadioButtonThenSaveItsEmailToUserDefaults() {
        let view = MyEvaluationsView()
        
    }
    
}
