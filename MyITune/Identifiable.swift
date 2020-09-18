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
