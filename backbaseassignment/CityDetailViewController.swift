//
//  CityDetailViewController.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var city: City?

    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()

        distributeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        updateData()
    }
    
    // MARK: - UI Customization
    
    private func setupUI() {
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        detailTableView.tableFooterView = UIView()
    }
    
    // MARK: - Data integration
    
    private func distributeData() {
        
        if let _city = city {
            
            title = _city.displayName
        }
        else {
            
            title = "N/A"
        }
        
        detailTableView.reloadData()
    }
    
    // MARK: - API integration
    
    private func updateData() {
        
        if let _city = city {
            
            OpenWeatherMap.shared.update(city: _city) {[weak self] (success, error) in
                
                if success,let _self = self {
                    
                    if let context = Persistence.shared.managedObjectContext {
                        
                        context.refresh(_city, mergeChanges: true)
                        _self.distributeData()
                    }
                }
            }
        }
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return city != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: LocationOverviewCell.reuseId, for: indexPath) as? LocationOverviewCell {
            
            if let _city = city {
                
                cell.setup(with: _city)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
