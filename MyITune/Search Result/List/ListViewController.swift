//
//  ListViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit
typealias ImageSuccess = (_ image: UIImage?) -> Void

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ResultViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
    }
    
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
            cell.nameLabel.text = rowItem.artistName
            cell.descriptionLabel.text = rowItem.trackName
            cell.activityIndcator.startAnimating()
         
            if let urlString = rowItem.artworkUrl100, let url = URL(string: urlString) {
                load(url: url) { (image) in
                    cell.previewImageView?.image =  image
                    cell.activityIndcator.stopAnimating()
                    cell.setNeedsLayout()
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let section = viewModel?.sectionItems[section] else { return UIView() }
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = section.sectionTitle
            label.textColor = .white
            label.contentMode = .left
            
            return label
        }()
        
        let headerBaseView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.black1E1E1E
            return view
        }()
        
        headerBaseView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:  headerBaseView.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: headerBaseView.bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: headerBaseView.leadingAnchor, constant: 20)
        ])
        
        return headerBaseView
    }
    
    func load(url: URL, completion: @escaping ImageSuccess) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = viewModel?.sectionItems[indexPath.section] else { return}
        guard let rowItem = section.rowItems?[indexPath.row] as? ResultRow else { return }
        
        if let previewURL = rowItem.previewUrl {
            let vc = DetailViewController(urlString: previewURL)
            present(vc, animated: true, completion: nil)
        }
    }
}
