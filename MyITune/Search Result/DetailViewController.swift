//
//  DetailViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.hidesWhenStopped = true
        
        return activity
    }()
    
    var urlString: String = ""
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("DONE", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        button.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    let webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: CGRect.zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()

    init(urlString: String) {
        super.init(nibName: nil, bundle: nil)
        self.urlString = urlString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.addSubview(webView)
        containerView.addSubview(activityView)
        containerView.addSubview(closeButton)
        
        setupConstraints()
        
        if let url = URL(string: urlString ) {
            activityView.startAnimating()
            webView.load(URLRequest(url: url))
            webView.navigationDelegate = self
            webView.uiDelegate = self
        }
    }
    
    private func setupConstraints() {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: view.topAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
            webView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            webView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        activityView.center = view.center
    }
    
    @objc private func doneButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: WKUIDelegate {
    
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityView.stopAnimating()
    }
}
