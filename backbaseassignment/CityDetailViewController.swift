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
    private var weather: WeatherQueryItem?
    
    private enum CellType: Int {
        
        case overview = 0, temperatureAndWind, precipation
    }
    private var cellTypes = [CellType]()

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
        
        cellTypes.removeAll()
        if let _ = city {
            cellTypes.append(.overview)
        }
        if let _ = weather {
            cellTypes.append(.temperatureAndWind)
            cellTypes.append(.precipation)
        }
        
        detailTableView.reloadData()
    }
    
    // MARK: - API integration
    
    private func updateData() {
        
        if let _city = city {
            
            let objectId = _city.objectID
            
            OpenWeatherMap.shared.update(city: _city) {[weak self] (success, weather, error) in
                
                if success, let _self = self {
                    
                    _self.weather = weather
                    
                    if let context = Persistence.shared.managedObjectContext {
                        
                        context.perform {
                            
                            do {
                                
                                let _city = try context.existingObject(with: objectId) as? City
                                _self.city = _city
                                
                                _self.distributeData()
                            }
                            catch let _error {

                                _self.show(error: _error)
                            }
                        }
                    }
                }
                else if let _error = error {
                    
                    self?.show(error: _error)
                }
                else {
                    
                    self?.show(message: NSLocalizedString("Error updating weather", comment: "General error when updating location weather"))
                }
            }
        }
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return cellTypes.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = cellTypes[indexPath.row]
        switch cellType {
            
        case .overview:
            if let _city = city, let cell = tableView.dequeueReusableCell(withIdentifier: LocationOverviewCell.reuseId, for: indexPath) as? LocationOverviewCell {
                
                cell.setup(with: _city)
                return cell
            }
            
        case .temperatureAndWind:
            if let _weather = weather, let cell = tableView.dequeueReusableCell(withIdentifier: LocationTemperatureAndWindCell.reuseId, for: indexPath) as? LocationTemperatureAndWindCell {
                
                cell.setup(with: _weather)
                return cell
            }
            
        case.precipation:
            if let _weather = weather, let cell = tableView.dequeueReusableCell(withIdentifier: LocationPrecipationCell.reuseId, for: indexPath) as? LocationPrecipationCell {
                
                cell.setup(with: _weather)
                return cell
            }
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
