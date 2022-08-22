//
//  CurrencyConverterRouter.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import Foundation
import UIKit

class CurrencyConverterRouter: PresenterToRouterCurrencyConverterProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = CurrencyConverterViewController.instance()
        
        let presenter: ViewToPresenterCurrencyConverterProtocol & InteractorToPresenterCurrencyConverterProtocol = CurrencyConverterPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CurrencyConverterRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CurrencyConverterInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
