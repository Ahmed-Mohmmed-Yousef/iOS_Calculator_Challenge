//
//  CurrencyConverterInteractor.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import Foundation

class CurrencyConverterInteractor: PresenterToInteractorCurrencyConverterProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterCurrencyConverterProtocol?
    let network: EGP_To_USD_APIProtocol = EGP_To_USD_API.shared
    
    func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(info:)), name: .calculationResult, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleNotification(info: NSNotification?) {
        print(info ?? "")
    }
    
    func getConversion(with value: Double) {
//        NetworkManager.shared.fetchData(value: value) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                do {
//                    let response = try JSONDecoder().decode(EGP_To_USD_Response.self, from: data)
//                    self.presenter?.conversionCompleted(value: response.conversionResult)
//                } catch {
//                    self.presenter?.conversionFailure(error: "Error in Parsing")
//                }
//            case .failure(let error):
//                self.presenter?.conversionFailure(error: error.description)
//            }
//        }
        network.getResult(egp: value) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultValue):
                self.presenter?.conversionCompleted(value: resultValue.conversionResult)
            case .failure(let error):
                self.presenter?.conversionFailure(error: error.description)
            }
        }
    }
    
    func saveResult(with value: Double) {
        SharedData.shared.setLastCurrencyResult(value: value)
    }
    
    func getLastCalculationResult() {
        let result = SharedData.shared.lastCalculationResult
        presenter?.lastCalculationResult(value: result)
    }
    
    func deleteLastCalculationResult() {
        SharedData.shared.setLastCalculationResult(value: nil)
    }
    
}
