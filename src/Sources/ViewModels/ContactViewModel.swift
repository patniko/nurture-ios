//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Mohammad Yasir on 13/04/21.
//

import Foundation

class ContactViewModel : Identifiable , ObservableObject {
    
    @Published var contacts : [Contact] = [
        Contact(id: UUID().uuidString, name: "Mom", gender: .female, birthDay: convertStringToDate(dateString: "1957-03-01"), datesToRemember: [DateToRemember(title: "Retirement", date: convertStringToDate(dateString: "2022-01-22"))],  interests: "", relationship: .parent, importance: .medium, address: "", city: "", state: "", zipCode: ""),
        Contact(id: UUID().uuidString, name: "Dad", gender: .male, birthDay: convertStringToDate(dateString: "1957-05-05"), datesToRemember: [DateToRemember(title: "Anniversary", date: convertStringToDate(dateString: "1979-03-01"))],  interests: "", relationship: .parent, importance: .medium, address: "", city: "", state: "", zipCode: ""),
        Contact(id: UUID().uuidString, name: "Maria", gender: .female, birthDay: convertStringToDate(dateString: "1986-04-08"), datesToRemember: [DateToRemember(title: "Wedding Anniversary", date: convertStringToDate(dateString: "2016-11-30"))],  interests: "", relationship: .spouse, importance: .high, address: "", city: "", state: "", zipCode: ""),
        Contact(id: UUID().uuidString, name: "Bri", gender: .female, birthDay: convertStringToDate(dateString: "1987-10-05"), datesToRemember: [],  interests: "", relationship: .sibling, importance: .normal, address: "", city: "", state: "", zipCode: ""),
    ]
    
    @Published var sortType : SortType = .name
    @Published var isPresented = false
    @Published var isEditPresented = false
    @Published var searched = ""
    
    func addContact(contact : Contact){
        contacts.append(contact)
        saveContacts(contacts: contacts)
    }

    func updateContact(contact : Contact){
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
            saveContacts(contacts: contacts)
        }
    }
    
    func removeContact(indexAt : IndexSet){
        contacts.remove(atOffsets: indexAt)
        saveContacts(contacts: contacts)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func saveContacts(contacts: [Contact]) {
        let url = getDocumentsDirectory().appendingPathComponent("little-things.contacts")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(contacts) {
            try? encoded.write(to: url)
        }
        self.contacts = loadContacts()
    }

    // Loading the object
    func loadContacts() -> [Contact] {
        let url = getDocumentsDirectory().appendingPathComponent("little-things.contacts")
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let loadedObject = try? decoder.decode([Contact].self, from: data) {
                return loadedObject
            }
        }
        return []
    }
    
    func sort(){
        switch sortType {
        case .name :
            contacts.sort(by: { $0.name < $1.name })
        case .birthDay :
            contacts.sort(by: { $0.daysUntilNextBirthDay ?? 999 < $1.daysUntilNextBirthDay ?? 999 })
        case .importance :
            contacts.sort(by: { $0.importance.rawValue > $1.importance.rawValue })
        }
    }
    
}

