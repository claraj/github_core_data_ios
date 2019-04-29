//
//  ViewController.swift
//  GitHubAPI
//
//  Created by student1 on 4/29/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var urlString: String?
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string: urlString!)!)
        webView.load(request)
    }
    
    


}

