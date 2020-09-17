//
//  SelectMediaViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

class SelectMediaViewController: UIViewController {

    let dataSource = ["Album", "Artist", "Book", "Movie", "Music Video", "Podcast", "Song"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension SelectMediaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SelectMediaTableViewCell.identifier) as? SelectMediaTableViewCell {
            cell.mediaTitle.text = dataSource[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    
}
extension SelectMediaViewController: UITableViewDelegate {
    
}
