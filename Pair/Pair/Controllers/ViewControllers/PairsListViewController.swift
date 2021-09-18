//
//  PairsListViewController.swift
//  Pair
//
//  Created by Natalie Hall on 9/18/21.
//

import UIKit

class PairsListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        PersonController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        newPersonAlert()
    }
    
    @IBAction func radomizeButtonTapped(_ sender: Any) {
        PersonController.shared.people.shuffle()
        PersonController.shared.saveToPersistenceStore()
        tableView.reloadData()
    }
    
    func newPersonAlert() {
        let alert = UIAlertController(title: "Add Person", message: "Add comeone new to the list", preferredStyle: .alert)
        alert.addTextField { nameTextField in
            nameTextField.placeholder = "Full Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let newPerson = alert.textFields![0].text, !newPerson.isEmpty else { return }
            PersonController.shared.createPerson(person: newPerson)
            self.tableView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true)
    }
    
}  // End of Class

extension PairsListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if PersonController.shared.people.count > 1 {
            return PersonController.shared.people.count / 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PersonController.shared.people.count > 1 {
            if PersonController.shared.people.count % 2 == 0 {
                return 2
            } else {
                if section == PersonController.shared.people.count / 2 - 1 {
                    return 3
                } else {
                    return 2
                }
            }
        } else if PersonController.shared.people.count == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = PersonController.shared.people[indexPath.row + (indexPath.section) * 2]
        
        cell.textLabel?.text = person.person
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if PersonController.shared.people.count > 0 {
            return "Group \(section + 1)"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = PersonController.shared.people[indexPath.row + (indexPath.section) * 2]
            PersonController.shared.deletePerson(person: person)
            tableView.reloadData()
        }
    }
    
}  //End of extension
