//
//  CalculatorPresenter.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import Foundation

class CalculatorPresenter: ViewToPresenterCalculatorProtocol {

    // MARK: Properties
    var view: PresenterToViewCalculatorProtocol?
    var interactor: PresenterToInteractorCalculatorProtocol?
    var router: PresenterToRouterCalculatorProtocol?
    
    var operationItems: [String] = []
    
    func viewDidLoad() {
//        interactor?.calculateResult()
    }
    
    func viewWillAppear() {
        interactor?.getLastCurrencyResult()
    }
    
    func executeOperation(operationType: OprationType, operand: Double) {
        if operand == 0.0 { return }
        interactor?.addOperation(operationType: operationType, operand: operand)
    }
    
    func numberOfHistoryItems() -> Int {
        return operationItems.count
    }
    
    func setupCell(cell: HistoryCellProtocol, at indexPath: IndexPath) {
        let item = operationItems[indexPath.row]
        cell.setupCell(text: item, indexPath: indexPath)
    }
    
    func didSelectCell(at index: Int) {
        interactor?.undo(at: index)
    }
    
    func undo() {
        interactor?.undo()
    }
    
    func redo() {
        interactor?.redo()
    }
    
    func reset() {
        interactor?.reset()
    }
}

extension CalculatorPresenter: InteractorToPresenterCalculatorProtocol {
    
    func lastCurrencyResult(value: Double?) {
        if let value = value {
            view?.setLastCurrencyResult(text: "\(value)")
            interactor?.deleteLastCurrencyResult()
        }
    }
    
    func calculatedResult(value: Double, operationItems: [String], canUndo: Bool, canRedo: Bool) {
        self.operationItems = operationItems
        let roundValue = round(100 * value) / 100
        view?.showResult(value: "Result = \(roundValue)")
        view?.updateCollectionView()
        view?.enableDisableDoBtns(canUndo: canUndo, canRedo: canRedo)
        interactor?.saveResult(with: roundValue)
    }
}
