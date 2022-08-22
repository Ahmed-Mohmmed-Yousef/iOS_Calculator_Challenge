//
//  HistoryCell.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 20/08/2022.
//

import UIKit

protocol HistoryCellProtocol {
    var indexPaht: IndexPath! { get set }
    func setupCell(text: String, indexPath: IndexPath)
}

class HistoryCell: UICollectionViewCell, HistoryCellProtocol {

    static let id = "HistoryCell"
    
    var indexPaht: IndexPath!
    
    @IBOutlet weak var label: Label!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupCell(text: String, indexPath: IndexPath) {
        self.indexPaht = indexPath
        label.text = text
    }
}
