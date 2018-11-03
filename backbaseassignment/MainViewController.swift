//
//  MainViewController.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var bookmarksTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    private struct Segue {
        
        static let addLocation  = "addLocation"
        static let cityDetail   = "cityDetail"
    }
    
    private var citiesFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupUI()
        
        loadCities()
    }
    
    // MARK: - UI Customization
    
    private func setupUI() {
        
        title = NSLocalizedString("Locations", comment: "Main screen navigation title")
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        bookmarksTableView.tableFooterView = UIView()
    }
    
    // Mark - Actions
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let count = citiesFetchedResultsController?.fetchedObjects?.count, count > 0 {
            
            return 1
        }
        return  0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = citiesFetchedResultsController?.fetchedObjects?.count, count > 0 {
            
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseId, for: indexPath) as? CityCell {
            
            if let cities = citiesFetchedResultsController?.fetchedObjects as? [City], indexPath.row < cities.count {
                
                let city = cities[indexPath.row]
                cell.setup(with: city)
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
        
        if let cities = citiesFetchedResultsController?.fetchedObjects as? [City], indexPath.row < cities.count {
            
            let city = cities[indexPath.row]
            performSegue(withIdentifier: Segue.cityDetail, sender: city)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if let cities = citiesFetchedResultsController?.fetchedObjects as? [City], indexPath.row < cities.count {
            
            return true
        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if let cities = citiesFetchedResultsController?.fetchedObjects as? [City], indexPath.row < cities.count {

            let deleteAction = UITableViewRowAction(style: .destructive, title: NSLocalizedString("Delete", comment: "Delete city action title"), handler: { (action, indexPath) in
                
                self.deleteCity(at: indexPath)
            })
            
            return [deleteAction]
        }
        
        return nil
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.cityDetail, let destination = segue.destination as? CityDetailViewController, let city = sender as? City {
            
            destination.city = city
        }
    }

    // MARK: - FetchedResultsController
    
    private func setupFetchedResultsController() {
        
        if citiesFetchedResultsController != nil {
            
            citiesFetchedResultsController!.fetchRequest.predicate = NSPredicate.init(value: false)
            
            do  {
                
                try citiesFetchedResultsController?.performFetch()
            }
            catch let error {
                
                print("Error clearing fetched results controller: \(error)")
            }
        }
                
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: City.entityName)
        let nameOrder = NSSortDescriptor(key: "name", ascending: false)
        request.sortDescriptors = [nameOrder]
        request.includesSubentities = false
        
        if citiesFetchedResultsController == nil {
            
            citiesFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Persistence.shared.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        }
        else {
            
            citiesFetchedResultsController!.fetchRequest.predicate = request.predicate
            citiesFetchedResultsController!.fetchRequest.sortDescriptors = request.sortDescriptors
        }
        
        citiesFetchedResultsController!.delegate = self
    }
    
    private var isProcessingChanges = false
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        DispatchQueue.main.async {
            
            if self.bookmarksTableView != nil, !self.isProcessingChanges {
                
                self.isProcessingChanges = true
                self.bookmarksTableView.beginUpdates()
            }
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        DispatchQueue.main.async {
            
            if self.isProcessingChanges && self.bookmarksTableView != nil {
                
                switch type {
                    
                case .insert:
                    if let _indexPath = newIndexPath {
                        self.bookmarksTableView.insertRows(at: [_indexPath], with: .top)
                    }
                    
                case .delete:
                    if let _indexPath = indexPath {
                        self.bookmarksTableView.deleteRows(at: [_indexPath], with: .none)
                    }
                    
                case .update:
                    if let _indexPath = indexPath {
                        self.bookmarksTableView.reloadRows(at: [_indexPath], with: .none)
                    }
                    
                case .move:
                    if let _indexPath = indexPath {
                        self.bookmarksTableView.deleteRows(at: [_indexPath], with: .none)
                    }
                    if let _indexPath = newIndexPath {
                        self.bookmarksTableView.insertRows(at: [_indexPath], with: .none)
                    }
                }
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        DispatchQueue.main.async {
            
            if self.bookmarksTableView != nil {
                
                if self.isProcessingChanges {
                    
                    self.bookmarksTableView.endUpdates()
                    self.isProcessingChanges = false
                }
                else {
                    
                    self.bookmarksTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Data integration
    
    private func loadCities() {
        
        do  {
            
            setupFetchedResultsController()
            
            try citiesFetchedResultsController?.performFetch()
        }
        catch let error {
            
            print("Error perfoming fetch: \(error)")
        }
    }
    
    private func deleteCity(at indexPath: IndexPath) {
        
        if let controller = citiesFetchedResultsController, let cities = controller.fetchedObjects as? [City], indexPath.row < cities.count {
            
            do {
            
                let context = controller.managedObjectContext
                let city = cities[indexPath.row]
                context.delete(city)
                try context.save()
            }
            catch let error {

                let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction((UIAlertAction(title: NSLocalizedString("OK", comment: "OK Button title"), style: .default, handler: nil)))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
