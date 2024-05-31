//
//  MainViewModifier.swift
//  TaskManager
//
//  Created by Mohammad Yasir on 13/04/21.
//

import Foundation
import SwiftUI

struct MainViewModifier : ViewModifier {
    
    @ObservedObject var contactVM : ContactViewModel
    
    func body(content : Content) -> some View {
        
        content
            .navigationBarTitle("Cherished")
            .navigationBarItems(trailing: HStack(spacing:30){
                EditButton()
                    .disabled(contactVM.contacts.isEmpty)
                Button(
                    action : { contactVM.isPresented.toggle()},
                    label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    })
            })
            .onChange(of: contactVM.sortType, perform: { _ in
                guard !contactVM.contacts.isEmpty else { return }
                withAnimation() {contactVM.sort()}
            })
            .fullScreenCover(isPresented: $contactVM.isPresented, content: {
                AddContactView(contactVM: contactVM)
            })
    }
    
}

