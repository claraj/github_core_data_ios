//
//  RepoTable.swift
//  GitHubAPI
//
//  Created by student1 on 4/29/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit
import CoreData

class RepoTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext?
    var fetchedResultsController: NSFetchedResultsController<UserEntity>?
    var gitHubController = GitHubService()
    
    @IBOutlet var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usersFetch = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        usersFetch.sortDescriptors = [ NSSortDescriptor(key: "name", ascending: true) ]
        fetchedResultsController = NSFetchedResultsController<UserEntity>(fetchRequest: usersFetch, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController?.delegate = self
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Error fetching \(error)")
        }
    }

    @IBAction func searchButton(_ sender: Any) {
        guard let username = usernameTextField.text else { return }
        gitHubController.searchFor(user: username, context: managedObjectContext!)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController!.fetchedObjects!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let user = fetchedResultsController!.fetchedObjects![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as UITableViewCell
        let name = user.name ?? "<Anon>"
        let login = user.login ?? ""
        cell.textLabel!.text = "\(name) (\(login))"
        cell.detailTextLabel!.text = "\(user.publicRepos) public repo(s)"
        return cell
    
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedCell = tableView.indexPathForSelectedRow!.row
        
        let destination = segue.destination as! WebViewController
        destination.urlString = fetchedResultsController?.fetchedObjects![selectedCell].htmlUrl
    }
    
    
}
