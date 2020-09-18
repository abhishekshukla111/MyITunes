//
//  ResultContainerViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

protocol ResultContainerDelegate: class {
    func resultContainerDidDismiss()
}

class ResultContainerViewController: UIViewController {
    @IBOutlet weak var childView: UIView!
    weak var delegate: ResultContainerDelegate?
    
    var listVC: ListViewController?
    var gridVC: GridViewController?
    
    
    var viewModel: ResultViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        addListController()
        if let viewModel = self.viewModel {
            for mediaType in viewModel.entities {
                ServiceManager().getMedia(term: viewModel.term, entity: mediaType.entity) { (results) in
                    //print(results)
                    viewModel.setupRowsForEntity(entity: mediaType.displayTitle, results: results)
                    self.listVC?.viewModel = viewModel
                    self.listVC?.reloadTableView()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.resultContainerDidDismiss()
    }
    
    @IBAction func listLayoutAction(_ sender: Any) {
        addListController()
    }
    
    @IBAction func gridLayoutAction(_ sender: Any) {
        addGridController()
    }
    
    private func addListController() {
        guard let listController = storyboard?.instantiateViewController(withIdentifier: ListViewController.identifier) as? ListViewController else {
            return
        }
        
        if let gridController = gridVC {
            remove(gridController)
        }
        listController.viewModel = viewModel
        listVC = listController
        add(listController)
    }
    
    private func addGridController() {
        guard let gridController = storyboard?.instantiateViewController(withIdentifier: GridViewController.identifier) as? GridViewController else {
            return
        }
        
        if let listController = listVC {
            remove(listController)
        }
        //gridController.viewModel = viewModel
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
