//
//  CalculatorRouter.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import Foundation
import UIKit

class CalculatorRouter: PresenterToRouterCalculatorProtocol {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        let viewController = CalculatorViewController.instance()
        
        let presenter: ViewToPresenterCalculatorProtocol & InteractorToPresenterCalculatorProtocol = CalculatorPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CalculatorRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CalculatorInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
    
}
