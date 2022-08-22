//
//  CurrencyConverterPresenter.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import Foundation

class CurrencyConverterPresenter: ViewToPresenterCurrencyConverterProtocol {

    // MARK: Properties
    var view: PresenterToViewCurrencyConverterProtocol?
    var interactor: PresenterToInteractorCurrencyConverterProtocol?
    var router: PresenterToRouterCurrencyConverterProtocol?
    
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        interactor?.getLastCalculationResult()
    }
    
    func userEnter(value: String) {
        if value.isEmpty {
            view?.fialuerAlert(message: "Text field is empty")
            return
        }
        guard let doubleValue = Double(value) else { return }
        view?.showIndicator()
        interactor?.getConversion(with: doubleValue)
    }
}

extension CurrencyConverterPresenter: InteractorToPresenterCurrencyConverterProtocol {
    
    func lastCalculationResult(value: Double?) {
        if let value = value {
            view?.setLastCalculationResult(text: "\(value)")
            interactor?.deleteLastCalculationResult()
        }
    }
    
    func conversionCompleted(value: Double) {
        DispatchQueue.main.async { [weak self] in
            let roundValue = round(100 * value) / 100
            guard let self = self else { return }
            self.view?.hideIndicator()
            self.view?.updateUSDLbl(value: roundValue.stringPrice)
            self.interactor?.saveResult(with: roundValue)
        }
    }
    
    func conversionFailure(error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.hideIndicator()
            self.view?.fialuerAlert(message: error.description)
        }
        
    }
    
    
}
