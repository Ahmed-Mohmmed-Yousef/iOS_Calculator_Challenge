//
//  MainTabBarViewController.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
    }
    
    private func setupTabs() {
        let calculaterVC = CalculatorRouter.createModule()
        calculaterVC.tabBarItem = UITabBarItem(title: "Calculater", image: UIImage(systemName: "equal.square"), tag: 0)
        
        let convertorVC = CurrencyConverterRouter.createModule()
        convertorVC.tabBarItem = UITabBarItem(title: "Convertor", image: UIImage(systemName: "arrow.2.squarepath"), tag: 1)
        
        setViewControllers([calculaterVC, convertorVC], animated: true)
    }
    

}
