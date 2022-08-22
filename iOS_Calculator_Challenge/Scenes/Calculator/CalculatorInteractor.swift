//
//  CalculatorInteractor.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import Foundation

class CalculatorInteractor: PresenterToInteractorCalculatorProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterCalculatorProtocol?
    
    var operationModel: OprationModel = OprationModel()
    
    func calculateResult() {
        let result = operationModel.calculateResult()
        let opertionItems = operationModel.currentOperations.map { "\($0.operationType.rawValue) \($0.operand)" }
        presenter?.calculatedResult(value: result, operationItems: opertionItems, canUndo: operationModel.canUndo, canRedo: operationModel.canRedo)
    }
    
    func addOperation(operationType: OprationType, operand: Double) {
        operationModel.addOperation(operationType: operationType, operand: operand)
        calculateResult()
    }
    
    func undo(at index: Int) {
        operationModel.undo(to: index)
        calculateResult()
    }
    
    func undo() {
        operationModel.undo()
        calculateResult()
    }
    
    func redo() {
        operationModel.redo()
        calculateResult()
    }
    
    func reset() {
        operationModel.clearOperations()
        calculateResult()
    }
    
    func saveResult(with value: Double) {
        SharedData.shared.setLastCalculationResult(value: value)
    }
    
    func getLastCurrencyResult() {
        let result = SharedData.shared.lastCurrencyResult
        presenter?.lastCurrencyResult(value: result)
    }

    func deleteLastCurrencyResult() {
        SharedData.shared.setLastCurrencyResult(value: nil)
    }
}
