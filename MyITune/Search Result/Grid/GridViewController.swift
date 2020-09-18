//
//  GridViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 3
    var viewModel: ResultViewModel?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

extension GridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) {
        guard let section = viewModel?.sectionItems[indexPath.section] else { return}
        guard let rowItem = section.rowItems?[indexPath.row] as? ResultRow else { return }
        
        if let previewURL = rowItem.previewUrl {
            let vc = DetailViewController(urlString: previewURL)
            parent?.present(vc, animated: true, completion: nil)
        }
    }
}

extension GridViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.sectionItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel?.sectionItems[section]
        return section?.rowCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = viewModel?.sectionItems[indexPath.section] else { return UICollectionViewCell() }
        guard let rowItem = section.rowItems?[indexPath.row] as? ResultRow else { return UICollectionViewCell() }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifier, for: indexPath) as? GridCollectionViewCell {
            cell.nameLabel.text = rowItem.artistName
//            cell.descriptionLabel.text = rowItem.trackName
//            cell.activityIndcator.startAnimating()
         
            if let urlString = rowItem.artworkUrl100, let url = URL(string: urlString) {
                load(url: url) { (image) in
                    cell.previewImageView?.image =  image
                    //cell.activityIndcator.stopAnimating()
                    cell.setNeedsLayout()
                }
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = viewModel?.sectionItems[indexPath.section] else { return UICollectionReusableView() }
      
      switch kind {
      
      case UICollectionView.elementKindSectionHeader:
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GridHeaderCollectionView.identifier,
                                                                               for: indexPath) as? GridHeaderCollectionView else {
            fatalError("Invalid view type")
        }

        headerView.headerTitle.text = section.sectionTitle
        return headerView
      default:
        // 4
        assert(false, "Invalid element type")
      }
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
}

// MARK: - Collection View Flow Layout Delegate
extension GridViewController : UICollectionViewDelegateFlowLayout {
  //1
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    //2
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  //3
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  // 4
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}
