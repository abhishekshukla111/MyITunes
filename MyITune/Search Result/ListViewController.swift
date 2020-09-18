//
//  ListViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: ResultViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    

}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sectionItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = viewModel?.sectionItems[section]
        return section?.rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = viewModel?.sectionItems[indexPath.section] else { return UITableViewCell() }
        guard let rowItem = section.rowItems?[indexPath.row] as? ResultRow else { return UITableViewCell() }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell {
            cell.titleLabel.text = rowItem.artistName
            cell.detailTextLabel?.text = rowItem.trackName
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension ListViewController: UITableViewDelegate {
    
}
