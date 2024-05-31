//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Mohammad Yasir on 13/04/21.
//

import SwiftUI

struct EditContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var contactVM : ContactViewModel
    var contact : Contact
    
    @State var name = ""
    @State var gender : Gender = .male
    @State var birthDay = Date()
    @State var address = ""
    @State var city = ""
    @State var state = ""
    @State var zipCode = ""
    @State var interests = ""
    @State var relationship : Relationship = .friend
    @State var importance : Importance = .normal
    
    init(contactVM: ContactViewModel, contact: Contact) {
        self.contactVM = contactVM
        self.contact = contact
        self.name = contact.name
        self.gender = contact.gender!
        self.birthDay = contact.birthDay!
        self.address = contact.address!
        self.city = contact.city!
        self.state = contact.state!
        self.zipCode = contact.zipCode!
        self.interests = contact.interests!
        self.relationship = contact.relationship
        self.importance = contact.importance
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Contact")) {
                    TextField("Full Name ", text : $name)
                }
                Section {
                    DisclosureGroup("Birth Day") {
                        DatePicker("", selection: $birthDay)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    Picker("Gender", selection: $gender) {
                        ForEach(Gender.allCases) { gender in
                            Label(
                                title: { Text(gender.title) },
                                icon: { })
                                .tag(gender)
                        }
                    }
                    Picker("Relationship", selection: $relationship) {
                        ForEach(Relationship.allCases) { relationship in
                            Label(
                                title: { Text(relationship.title) },
                                icon: { })
                                .tag(relationship)
                        }
                    }
                }
                
                Section {

                    TextField("Address ", text : $address)
                    TextField("City ", text : $city)
                    TextField("State ", text : $state)
                    TextField("Zip Code ", text : $zipCode)
                }
                Section {
                    Picker("Importance", selection: $importance) {
                        ForEach(Importance.allCases) { importance in
                            Label(
                                title: { Text(importance.title) },
                                icon: { })
                                .foregroundColor(importance.color)
                                .tag(importance)
                        }
                    }
                }
                Section(header: Text("Interests")) {
                    TextEditor(text: $interests)
                }
                
            }
            .navigationBarTitle("Add", displayMode: .inline)
            .navigationBarItems(
                                leading: Button(action:{
                                                presentationMode.wrappedValue.dismiss() },
                                                label : {
                                                    Text("Cancel")
                                                    .foregroundColor(.red)
                                                }),
                                trailing: Button(action:{
                                    contactVM.addContact(contact: .init(id: UUID().uuidString, name: name, gender: gender, birthDay: birthDay, datesToRemember: [],  interests: interests, relationship: relationship, importance: importance, address: address, city: city, state: state, zipCode: zipCode))
                                                    presentationMode.wrappedValue.dismiss()},
                                                   label:{
                                                    Text("Save")
                                                   }).disabled(name.isEmpty)
            )
        }
    }
}

struct EditContactView_Previews: PreviewProvider {
    static var previews: some View {
        EditContactView(contactVM: ContactViewModel(), contact: Contact(id: UUID().uuidString, name: "Bri", gender: .female, birthDay: convertStringToDate(dateString: "1987-10-05"), datesToRemember: [],  interests: "", relationship: .sibling, importance: .normal, address: "", city: "", state: "", zipCode: ""))
    }
}
