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
    var selectedMediaTypes: [MediaTypesDataSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServiceManager().fetchFilms()
        
    }
    
    @IBAction func mediaTypeButtionAction(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SelectMediaViewController.identifier) as? SelectMediaViewController {
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: SelectMediaDelegate {
    func mediaSelectionDidFinish(dataSource: [MediaTypesDataSource]) {
        selectedMediaTypes = dataSource
    }
}


