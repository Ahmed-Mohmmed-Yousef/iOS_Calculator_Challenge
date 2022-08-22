//
//  CalculatorViewController.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: ViewToPresenterCalculatorProtocol?
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var oprationBtns: [UIButton]!
    @IBOutlet weak var equalBtn: UIButton!
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var redoBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarBtn()
        setupTextField()
        setupCollectionView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    private func setupBarBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    }
    
    @objc private func handleReset() {
        presenter?.reset()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: HistoryCell.id, bundle: .main), forCellWithReuseIdentifier: HistoryCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func setupTextField() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        textField.inputAccessoryView = doneToolbar
        textField.delegate = self
    }
    
    @objc private func doneButtonAction() {
        view.endEditing(true)
    }
    
    private func setupEqualBtn() {
        let isValidNumber = Double(textField.text ?? "") != nil
        let isOpBtnSelected = oprationBtns.first(where: { $0.isSelected }) != nil
        equalBtn.isEnabled = (isOpBtnSelected && isValidNumber)
    }
    
    private func setSelectedBtn(btn: UIButton?) {
        oprationBtns.forEach { btn in
            btn.isSelected = false
        }
        btn?.isSelected = true
        setupEqualBtn()
    }
    
    @IBAction func oprationBtnTapped(_ sender: UIButton) {
        setSelectedBtn(btn: sender)
    }
    
    @IBAction func equalBtnTapped(_ sender: UIButton) {
        view.endEditing(true)
        guard let doubleValue = Double(textField.text ?? "") else { return }
        guard let selectedBtn = oprationBtns.first(where: { $0.isSelected }) else { return }
        let oprationType = OprationType.allCases[selectedBtn.tag]
        presenter?.executeOperation(operationType: oprationType, operand: doubleValue)
        
    }
    @IBAction func undoBtnTapped(_ sender: UIButton) {
        presenter?.undo()
    }
    @IBAction func redoBtnTapped(_ sender: UIButton) {
        presenter?.redo()
    }
}

extension CalculatorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let ACCEPTABLE_NUMBERS = "0123456789."
        let numberOnly = NSCharacterSet.init(charactersIn: ACCEPTABLE_NUMBERS).inverted
        return string.rangeOfCharacter(from: numberOnly) == nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        textField.text = "\(Double(text) ?? 0.0)"
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setupEqualBtn()
    }
}

extension CalculatorViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfHistoryItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.id, for: indexPath) as! HistoryCell
        presenter?.setupCell(cell: cell, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCell(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 10
    }
    
}

extension CalculatorViewController: PresenterToViewCalculatorProtocol{
    // TODO: Implement View Output Methods
    
    func setLastCurrencyResult(text: String) {
        textField.text = text
    }
    
    func showResult(value: String) {
        view.endEditing(true)
        resultLbl.text = value
        textField.text = ""
        setSelectedBtn(btn: nil)
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
    
    func enableDisableDoBtns(canUndo: Bool, canRedo: Bool) {
        undoBtn.isEnabled = canUndo
        redoBtn.isEnabled = canRedo
    }
}
