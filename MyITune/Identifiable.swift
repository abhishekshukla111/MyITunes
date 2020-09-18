//
//  SummaryViewController.swift
//  FrontierX
//
//  Created by Abhishek Shukla on 5/2/20.
//  Copyright © 2020 FourthFrontier. All rights reserved.
//
import UIKit

protocol Identifiable: class {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Identifiable {
    // By conforming to `Identifiable` protocol, `UITableViewCell` will have default `identifier` static property which returns string value of its class name.
}

extension UIViewController: Identifiable {
    // By conforming to `Identifiable` protocol, `UIViewController` will have default `identifier` static property which returns string value of its class name.
}

extension UICollectionViewCell: Identifiable {
    
}

extension UICollectionReusableView: Identifiable {
    
}


extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
    
    static let black1E1E1E: UIColor = .rgb(30, 30, 30) //Dark Black Color used for Titles
}
