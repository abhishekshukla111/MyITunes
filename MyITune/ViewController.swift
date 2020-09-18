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
    @IBOutlet weak var artistTextField: UITextField!
    
    var selectedMediaTypes: [MediaType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistTextField.placeholder = "Please search by Artist"
        
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
        if let textfield = artistTextField, let textFieldText = textfield.text {
            if textFieldText.isEmpty {
                showAlert(withMessage: "Please Select an Artist.")
                return
            }
            
            if selectedMediaTypes.isEmpty {
                showAlert(withMessage: "Please Select a Media Types.")
                return
            }
            
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: ResultContainerViewController.identifier) as? ResultContainerViewController {
                vc.delegate = self
                let term: String = artistTextField.text ?? ""
                let viewModel = ResultViewModel(term: term, entities: selectedMediaTypes)
                
                vc.viewModel = viewModel
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            showAlert(withMessage: "Please Select a Media Type and Artist")
        }
    }
    
    private func showAlert(withMessage message: String) {
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
    
    func formateSelectedMedia(selectedMedia: [MediaType]) {
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
        
        if selectedMediaTypes.isEmpty {
            mediaTypesLabel.text = "Please Select Media Type"
            return
        }
        
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
        mediaTypesLabel.textColor = .lightGray
        artistTextField.text = ""
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

