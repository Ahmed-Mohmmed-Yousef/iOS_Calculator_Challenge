//
//  CurrencyConverterViewController.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//  
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: ViewToPresenterCurrencyConverterProtocol?
    @IBOutlet weak var usdLbl: UILabel!
    @IBOutlet var egpTF: UITextField!
    @IBOutlet weak var convertBtn: UIButton!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEgpTextField()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    private func setupEgpTextField() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        egpTF.inputAccessoryView = doneToolbar
        egpTF.delegate = self
    }
    
    @objc func doneButtonAction() {
        egpTF.resignFirstResponder()
    }

    @IBAction func convertBtnTapped(_ sender: Any) {
        view.endEditing(true)
        guard let egpText = egpTF.text else { return }
        presenter?.userEnter(value: egpText)
    }
    
    
}


extension CurrencyConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let ACCEPTABLE_NUMBERS = "0123456789."
        let numberOnly = NSCharacterSet.init(charactersIn: ACCEPTABLE_NUMBERS).inverted
        return string.rangeOfCharacter(from: numberOnly) == nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        textField.text = "\(Double(text) ?? 0.0)"
    }
}

extension CurrencyConverterViewController: PresenterToViewCurrencyConverterProtocol {
    // TODO: Implement View Output Methods
    
    func setLastCalculationResult(text: String) {
        egpTF.text = text
    }
    
    func updateUSDLbl(value: String) {
        usdLbl.text = value
    }
}
