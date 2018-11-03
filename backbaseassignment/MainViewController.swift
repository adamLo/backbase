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
        
        static let addLocation = "addLocation"
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
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.addLocation, let destination = segue.destination as? AddLocationViewController {
            
            // TODO: Add callback here
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
    
    private func loadCities() {
        
        do  {
            
            setupFetchedResultsController()
            
            try citiesFetchedResultsController?.performFetch()
        }
        catch let error {
            
            print("Error perfoming fetch: \(error)")
        }
    }
}
