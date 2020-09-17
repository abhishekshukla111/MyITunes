//
//  ViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 17/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        ServiceManager().getSearchResults(searchTerm: "jackjohnson") { (data, error) in
//            print("Data")
//        }
        
        ServiceManager().fetchFilms()
        
    }
    
}


//https://itunes.apple.com/search?term=jackjohnson&amp;entity=musicVideo
