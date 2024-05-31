//
//  TaskListView.swift
//  TaskManager
//
//  Created by Mohammad Yasir on 13/04/21.
//

import SwiftUI

struct ContactListView: View {
    
    @ObservedObject var contactVM : ContactViewModel
    
    var body: some View {
        List {
            ForEach (contactVM.contacts.filter {
                        self.contactVM.searched.isEmpty ? true : $0.name.localizedCapitalized.contains(self.contactVM.searched)} ){ contact in
                            ContactView(contactVM: contactVM, contact: contact)
            }
            .onDelete(perform: {
                contactVM.removeContact(indexAt: $0)
            })
        }.listStyle(InsetListStyle())
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView(contactVM: ContactViewModel())
    }
}


