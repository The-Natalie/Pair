//
//  PersonController.swift
//  Pair
//
//  Created by Natalie Hall on 9/18/21.
//

import Foundation

class PersonController {
    
    // MARK: - Shared Instance
    static let shared = PersonController()
    
    // MARK: - SOT
    var people: [Person] = []
    
    // MARK: - CRUD
    func createPerson(person: String) {
        let newPerson = Person(person: person)
        people.append(newPerson)
        
        saveToPersistenceStore()
    }
    
    func deletePerson(person: Person) {
        guard let index = people.firstIndex(of: person) else { return }
        people.remove(at: index)
        
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Pair.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPErsistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}  // End of Class
