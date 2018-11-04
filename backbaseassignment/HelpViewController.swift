//
//  HelpViewController.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 04/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var helpWebView: UIWebView!
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupUI()
        loadHelp()
    }
    
    // MARK: - UI Customization
    
    private func setupUI() {
        
        title = NSLocalizedString("Help", comment: "Help screen title")
    }
    
    // MARK: - Data integration
    
    private func loadHelp() {
        
        let htmlFile = Bundle.main.path(forResource: "help", ofType: "html")
        let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        helpWebView.loadHTMLString(html!, baseURL: nil)
    }

}
