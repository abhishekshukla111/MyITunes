//
//  ResultContainerViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

class ResultContainerViewController: UIViewController {
    @IBOutlet weak var childView: UIView!
    
    var listVC: ListViewController?
    var gridVC: GridViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func listLayoutAction(_ sender: Any) {
        guard let listController = storyboard?.instantiateViewController(withIdentifier: ListViewController.identifier) as? ListViewController else {
            return
        }
        
        if let gridController = gridVC {
            remove(gridController)
        }
        listVC = listController
        add(listController)
    }
    
    @IBAction func gridLayoutAction(_ sender: Any) {
        guard let gridController = storyboard?.instantiateViewController(withIdentifier: GridViewController.identifier) as? GridViewController else {
            return
        }
        
        if let listController = listVC {
            remove(listController)
        }
        gridVC = gridController
        add(gridController)
    }
}

extension ResultContainerViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        childView.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove(_ child: UIViewController) {
        guard parent != nil else {
            return
        }

        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
