//
//  CurrencyConverterContract.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCurrencyConverterProtocol: LoadableViewProtocol {
    func setLastCalculationResult(text: String)
    func updateUSDLbl(value: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCurrencyConverterProtocol {
    
    var view: PresenterToViewCurrencyConverterProtocol? { get set }
    var interactor: PresenterToInteractorCurrencyConverterProtocol? { get set }
    var router: PresenterToRouterCurrencyConverterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func userEnter(value: String)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCurrencyConverterProtocol {
    
    var presenter: InteractorToPresenterCurrencyConverterProtocol? { get set }
    
    func getConversion(with value: Double)
    func setObserver()
    func removeObserver()
    func saveResult(with value: Double)
    func getLastCalculationResult()
    func deleteLastCalculationResult()
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCurrencyConverterProtocol {
    func lastCalculationResult(value: Double?)
    func conversionCompleted(value: Double)
    func conversionFailure(error: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCurrencyConverterProtocol {
    
}
