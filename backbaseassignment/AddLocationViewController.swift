//
//  AddLocationViewController.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var activityHolderView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityLabel: UILabel!
    
    private let animationDuration: TimeInterval = 0.3
        
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - UI Customization
    
    private func setupUI() {
        
        setupSearch()
        hideActivity(animated: false)
    }
    
    private func setupSearch() {
        
        searchTextField.font = UIFont.defaultFont(style: .regular, size: .base)
        searchTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("City name, country", comment: "Add location search placeholder"), attributes: [NSAttributedString.Key.font: UIFont.defaultFont(style: .regular, size: .base), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        searchButton.titleLabel?.font = UIFont.defaultFont(style: .bold, size: .base)
        searchButton.setTitle(NSLocalizedString("Search", comment: "Search button title"), for: .normal)
        searchButton.setTitleColor(UIColor.darkGray, for: .normal)
    }

    // MARK: - UI manipulations
    
    private func showActivity() {
        
        if activityHolderView.isHidden {
            
            activityHolderView.alpha = 0
            activityHolderView.isHidden = false
            
            UIView.animate(withDuration: animationDuration, animations: {
                
                self.activityHolderView.alpha = 1.0
                
            }) { (finished) in
                
                self.activityIndicator.startAnimating()
            }
        }
    }
    
    private func hideActivity(animated: Bool) {
        
        if !activityHolderView.isHidden {
            
            let completion: ((Bool) -> Void) = { (finished) in
                
                self.activityIndicator.stopAnimating()
                self.activityHolderView.isHidden = true
                self.activityHolderView.alpha = 1.0
            }
            
            if animated {
                
                UIView.animate(withDuration: animationDuration, animations: {
                    
                    self.activityHolderView.alpha = 0.0
                    
                }, completion: completion)
            }
            else {
                
                completion(true)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func userTappedOnMap(_ sender: UITapGestureRecognizer) {
        
        let tapPoint = sender.location(in: mapView)
        let location = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        
        query(location: location)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        if let _query = searchTextField.text, !_query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            search(for: _query.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
    @IBAction func searhDidEndOnExit(_ sender: Any) {
        
        searchButtonTapped(sender)
    }
    
    // MARK: - Data integration
    
    private func display(result: WeatherQueryItem) {
        
        let alert = UIAlertController(title: NSLocalizedString("Found a location!", comment: "Alert dialog title when found a location"), message: result.displayName, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Select", comment: "Select action title"), style: .default, handler: { (action) in
            
            self.save(weather: result, completion: { (success, error) in
                
                if success {
                    
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    
                    let alert = UIAlertController(title: nil, message: error?.localizedDescription ?? NSLocalizedString("Error saving location", comment: "Error message when saving location"), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button title"), style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func displayNoResult(error: String?) {
        
        let alert = UIAlertController(title: NSLocalizedString("Sorry, no location found!", comment: "Alert dialog title when location not found"), message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK button title"), style: .cancel, handler: { (action) in
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func query(location: CLLocationCoordinate2D) {

        showActivity()
        
        OpenWeatherMap.shared.query(location: location) {[weak self] (item, error) in
            
            guard let _self = self else {return}
            
            _self.hideActivity(animated: true)
            
            if let _item = item {
                
                _self.display(result: _item)
            }
            else {
                
                _self.displayNoResult(error: error?.localizedDescription)
            }
        }
    }
    
    private func save(weather: WeatherQueryItem, completion: ((_ success: Bool, _ error: Error?) -> ())?) {
        
        let context = Persistence.shared.createNewManagedObjectContext()
        
        context.perform {

            if let _ = City.newCity(in: context, from: weather) {
                
                do {
                    
                    try context.save()
                    
                    DispatchQueue.main.async {
                        
                        completion?(true, nil)
                    }
                    
                }
                catch let error {
                    
                    DispatchQueue.main.async {
                    
                        completion?(false, error)
                    }
                }
            }
        }
    }
    
    private func search(for query: String) {
        
        showActivity()
        
        OpenWeatherMap.shared.search(city: query) {[weak self] (item, error) in
            
            guard let _self = self else {return}
            
            _self.hideActivity(animated: true)
            
            if let _item = item {
                
                _self.display(result: _item)
            }
            else {
                
                _self.displayNoResult(error: error?.localizedDescription)
            }
        }
    }
}
