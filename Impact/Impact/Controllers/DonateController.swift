//
//  DonateController.swift
//  Impact
//
//  Created by Connie Guan on 8/8/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

//import UIKit
//
//class DonateController: UIViewController, UIWebViewDelegate{
//    
//   
//    @IBOutlet weak var donateWebView: UIWebView!
//    @IBOutlet weak var donateActivityIndicator: UIActivityIndicatorView!
//    @IBOutlet weak var donateBackButton: UIButton!
//    
//    @IBOutlet weak var donateForwardButton: UIButton!
//    
//    var donateUrl = ""
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        donateWebView.delegate = self
//        if let url = URL(string: donateUrl) {
//            let request = URLRequest(url: url)
//            donateWebView.loadRequest(request)
//        }
//    }
//    
//    func webViewDidStartLoad(_ webView: UIWebView) {
//        donateActivityIndicator.startAnimating()
//    }
//    
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        donateActivityIndicator.stopAnimating()
//        donateActivityIndicator.isHidden = true
//    }
//
//    
//    @IBAction func donateBackTapped(_ sender: UIButton) {
//        if donateWebView.canGoBack{
//            donateWebView.goBack()
//        }
//    }
//    
//    @IBAction func donateForwardTapped(_ sender: UIButton) {
//        if donateWebView.canGoForward{
//            donateWebView.goForward()
//        }
//    }
//    
//}
//
