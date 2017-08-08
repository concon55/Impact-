//
//  WebsiteController.swift
//  Impact
//
//  Created by Connie Guan on 8/8/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class WebsiteController: UIViewController, UIWebViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var websiteUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        if let url = URL(string: websiteUrl) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
}

