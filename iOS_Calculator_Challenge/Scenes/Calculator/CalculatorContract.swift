//
//  CalculatorContract.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCalculatorProtocol {
    func setLastCurrencyResult(text: String)
    func showResult(value: String)
    func updateCollectionView()
    func enableDisableDoBtns(canUndo: Bool, canRedo: Bool)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCalculatorProtocol {
    
    var view: PresenterToViewCalculatorProtocol? { get set }
    var interactor: PresenterToInteractorCalculatorProtocol? { get set }
    var router: PresenterToRouterCalculatorProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func executeOperation(operationType: OprationType, operand: Double)
    func numberOfHistoryItems() -> Int
    func setupCell(cell: HistoryCellProtocol, at indexPath: IndexPath)
    func didSelectCell(at index: Int)
    func undo()
    func redo()
    func reset()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCalculatorProtocol {
    
    var presenter: InteractorToPresenterCalculatorProtocol? { get set }
    func calculateResult()
    func addOperation(operationType: OprationType, operand: Double)
    func saveResult(with value: Double)
    func getLastCurrencyResult()
    func deleteLastCurrencyResult()
    func undo(at index: Int)
    func undo()
    func redo()
    func reset()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCalculatorProtocol {
    func lastCurrencyResult(value: Double?)
    func calculatedResult(value: Double, operationItems: [String], canUndo: Bool, canRedo: Bool)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCalculatorProtocol {
    
}
