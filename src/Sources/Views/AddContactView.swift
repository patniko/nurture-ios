//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Mohammad Yasir on 13/04/21.
//

import SwiftUI

struct AddContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var contactVM : ContactViewModel
    
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
                                trailing: Button(action:{contactVM.addContact(contact: .init(id: UUID().uuidString, name: name, gender: gender, birthDay: birthDay, datesToRemember: [],  interests: interests, relationship: relationship, importance: importance, address: address, city: city, state: state, zipCode: zipCode))
                                                    presentationMode.wrappedValue.dismiss()},
                                                   label:{
                                                    Text("Save")
                                                   }).disabled(name.isEmpty)
            )
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(contactVM: ContactViewModel())
    }
}
