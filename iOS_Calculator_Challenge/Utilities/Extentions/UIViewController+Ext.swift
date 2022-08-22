//
//  UIViewController+Ext.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 22/08/2022.
//
import UIKit

//MARK:- UIViewController Extention
extension UIViewController {
    
    static var vcIdentifier: String { String(describing: self) }
    
    static func instance() -> Self {
        let vc = UIStoryboard(name: vcIdentifier, bundle: .main).instantiateViewController(withIdentifier: vcIdentifier) as! Self
        return vc
    }
}

//MARK:- UIViewController with ViewProtocol
extension UIViewController: LoadableViewProtocol {
    
    func showIndicator() {
        let grayView = UIView(frame: view.bounds)
        grayView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        view.addSubview(grayView)
        let indicator = UIActivityIndicatorView(style: .medium)
        grayView.addSubview(indicator)
        indicator.center = grayView.center
        indicator.startAnimating()
        grayView.tag = 100
    }
    
    func hideIndicator() {
        let grayView = view.viewWithTag(100)
        grayView?.removeFromSuperview()
    }
    
    func fialuerAlert(message: String?) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertVC.addAction(okBtn)
        present(alertVC, animated: true, completion: nil)
    }
    
}
