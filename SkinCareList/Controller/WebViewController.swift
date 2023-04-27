//
//  WebViewController.swift
//  SkinCareList
//
//  Created by angelique fourny on 25/04/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    var searchTerm: String?
    var closeButton: UIButton!
    var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundView()
        setupWebView()
        setupCloseButton()
        
        if let searchTerm = searchTerm {
            performGoogleSearch(searchTerm: searchTerm)
        }
    }
    
    func setupBackgroundView() {
        backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(backgroundView)
    }
    
    func setupWebView() {
        let webViewFrame = CGRect(x: 20, y: 60, width: self.view.bounds.width - 40, height: self.view.bounds.height - 120)
        webView = WKWebView(frame: webViewFrame)
        webView.layer.cornerRadius = 10
        webView.layer.masksToBounds = true
        self.view.addSubview(webView)
    }
    
    func setupCloseButton() {
        closeButton = UIButton(type: .system)
        closeButton.setTitle("Fermer", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        closeButton.center = CGPoint(x: self.view.bounds.midX, y: webView.frame.maxY + 30)
        self.view.addSubview(closeButton)
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func performGoogleSearch(searchTerm: String) {
        let escapedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "https://www.google.com/search?q=\(escapedSearchTerm)") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
