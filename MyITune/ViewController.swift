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
    @IBOutlet weak var mediaTypesLabel: UILabel!
    var selectedMediaTypes: [MediaType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func mediaTypeButtionAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: SelectMediaViewController.identifier) as? SelectMediaViewController {
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if !selectedMediaTypes.isEmpty {
            if let vc = storyboard?.instantiateViewController(withIdentifier: ResultContainerViewController.identifier) as? ResultContainerViewController {
                vc.delegate = self
                let term: String = "jackjohnson"
                let viewModel = ResultViewModel(term: term, entities: selectedMediaTypes)
                
                vc.viewModel = viewModel
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            showAlert()
        }
    }
    
    private func showAlert() {
        let message = "Please Select a media type and Artist"
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { (_) in
        
        }
        alertcontroller.addAction(actionOK)
        present(alertcontroller, animated: true, completion: nil)
    }
}

extension ViewController: SelectMediaDelegate {
    func mediaSelectionDidFinish(dataSource: [MediaType]) {
        formateSelectedMedia(selectedMedia: dataSource)
    }
    
    private func formateSelectedMedia(selectedMedia: [MediaType]) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.blue,
            .font: UIFont.boldSystemFont(ofSize: 20)]

        let blankAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.clear,
            .font: UIFont.boldSystemFont(ofSize: 20)]
        
        for mediaType in selectedMedia {
            if mediaType.isSelected {
                selectedMediaTypes.append(mediaType)
            }
        }
        
        let finalAttributedString = NSMutableAttributedString()
        
        for selectedMediaType in selectedMediaTypes {
            let attributedString = NSAttributedString(string: selectedMediaType.displayTitle, attributes: attributes)
            let spaceAttributedSting = NSAttributedString(string: "  ", attributes: blankAttributes)
            finalAttributedString.append(attributedString)
            finalAttributedString.append(spaceAttributedSting)
        }
        
        mediaTypesLabel.attributedText = finalAttributedString
    }
}

extension ViewController: ResultContainerDelegate {
    func resultContainerDidDismiss() {
        selectedMediaTypes.removeAll()
        mediaTypesLabel.text = "Please Select Media Type"
    }
}

