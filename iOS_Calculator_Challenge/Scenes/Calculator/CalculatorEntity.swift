//
//  CalculatorEntity.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 20/08/2022.
//

import Foundation

class OprationModel {
    
    private(set) var operations: [Operation?] = []
    var currentOperations: [Operation] { operations.compactMap { $0 } }
    private(set) var redoOperations: [Operation] = []
    var canUndo: Bool { !currentOperations.isEmpty }
    var canRedo: Bool { !redoOperations.isEmpty }
    
    func calculateResult() -> Double {
        var result: Double = 0
        currentOperations.forEach { opration in
            switch opration.operationType {
            case .addition:
                result += opration.operand
            case .subtraction:
                result -= opration.operand
            case .multiplication:
                result *= opration.operand
            case .division:
                if opration.operand == 0.0 { break }
                result /= opration.operand
            }
        }
        return result
    }
    
    func addOperation(operationType: OprationType, operand: Double) {
        let operation = Operation(index: operations.count, operand: operand, operationType: operationType)
        operations.append(operation)
    }
    
    func undo() {
        if canUndo {
            guard let lastOperation = currentOperations.last else { return }
            operations[lastOperation.index] = nil
            redoOperations.append(lastOperation)
        }
    }
    
    func redo() {
        if canRedo {
            let operation = redoOperations.removeLast()
            operations[operation.index] = operation
        }
    }
    
    func undo(to index: Int) {
        let operation = currentOperations[index]
        operations[operation.index] = nil
        redoOperations.append(operation)
    }
    
    func clearOperations() {
        operations.removeAll()
        redoOperations.removeAll()
    }
    
}
