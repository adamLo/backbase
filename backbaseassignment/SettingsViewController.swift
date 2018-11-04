//
//  SettingsViewController.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 04/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var unitsButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var helpButton: UIButton!
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        
        updateUnitsButtonTitle()
    }
    
    // MARK: - UI Customization
    
    private func setupUI() {
        
        title = NSLocalizedString("Settings", comment: "Settings screen title")
        
        unitsLabel.text = NSLocalizedString("Units", comment: "Units settings label title")
        unitsLabel.font = UIFont.defaultFont(style: .regular, size: .base)
        
        unitsButton.titleLabel?.font = UIFont.defaultFont(style: .bold, size: .base)
        
        helpButton.titleLabel?.font = UIFont.defaultFont(style: .bold, size: .base)
        helpButton.setTitle(NSLocalizedString("Help", comment: "Help button title"), for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func unitsButtonTouched(_ sender: Any) {
        
        changeUnits()
    }
    
    @IBAction func clearButtonTouched(_ sender: Any) {
        
        clearBookmarks()
    }
    
    // MARK: - Data integration
    
    private func updateUnitsButtonTitle() {
        
        unitsButton.setTitle(UserDefaults.standard.units.localizedDescription, for: .normal)
    }
    
    private func changeUnits() {
        
        let alert = UIAlertController(title: NSLocalizedString("Change units?", comment: "Units change dialog title"), message: UserDefaults.standard.units.localizedDescription, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Units.imperial.localizedDescription, style: .default, handler: { (action) in
            
            UserDefaults.standard.units = .imperial
            self.updateUnitsButtonTitle()
        }))
        alert.addAction(UIAlertAction(title: Units.metric.localizedDescription, style: .default, handler: { (action) in
            
            UserDefaults.standard.units = .metric
            self.updateUnitsButtonTitle()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel btton title"), style: .cancel, handler: nil))
        
        alert.popoverPresentationController?.sourceView = unitsButton
        alert.popoverPresentationController?.sourceRect = unitsButton.bounds
        
        present(alert, animated: true, completion: nil)
    }
    
    private func clearBookmarks() {
        
        let alert = UIAlertController(title: nil, message: NSLocalizedString("Are you sure you want to delete all bookmarked cities?", comment: "Clear dialog message"), preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: "Delete button title"), style: .destructive, handler: { (action) in

            let context = Persistence.shared.createNewManagedObjectContext()
            
            context.perform {
                
                do {
                    
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: City.entityName)
                    
                    if let results = try context.fetch(request) as? [City], !results.isEmpty {
                        
                        for city in results {
                            
                            context.delete(city)
                        }
                        
                        try context.save()
                        
                        DispatchQueue.main.async {
                            self.show(message: NSLocalizedString("All bookmarked cities deleted", comment: "Message when all cities deleted"))
                        }
                        
                    }
                    
                }
                catch let error {
                    
                    DispatchQueue.main.async {
                        self.show(error: error)
                    }
                }
            }
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button title"), style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
