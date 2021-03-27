//
//  TabBarViewController.swift
//  TableHW
//
//  Created by Даниил Автушко on 22.03.2021.
//

import Foundation
import UIKit
class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let mainVC = UINavigationController(rootViewController: myViewController())
        mainVC.title = "mainVC"
//        let mainVC = myViewController()
//        mainVC.title = "mainVC"
        let sectionVC = sectionViewController()
        sectionVC.title = "sectionvc"
        self.viewControllers = [mainVC,sectionVC]
    }
}
