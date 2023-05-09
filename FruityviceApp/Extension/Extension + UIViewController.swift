//
//  Extension + UIView.swift
//  FruityviceApp
//
//  Created by Sergei Bakhmatov on 09.05.2023.
//

import UIKit

extension UIViewController {
    func setupBackground(for view: UIView) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundPhoto") ?? UIImage())
    }
}
