//
//  aaa.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/09.
//

import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
  
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
  
}
