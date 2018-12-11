//
//  ViewController.swift
//  recipefun
//
//  Created by Daniel Richard on 11/27/18.
//  Copyright © 2018 Daniel Richard. All rights reserved.
//

import UIKit
import WebKit
import CoreData


class ViewController: UIViewController, WKNavigationDelegate{
    
    @IBOutlet var webView: WKWebView!
    
    
    
    var videoCode: String?
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        
        // 1
        let url = URL(string: videoCode!)!
        webView.load(URLRequest(url: url))
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
}

