//
//  ContentView.swift
//  TaskManager
//
//  Created by Mohammad Yasir on 13/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contactVM = ContactViewModel()
    
    @State var searched = ""
    
    var body: some View {
            NavigationView{
                VStack{
                    TaskSearchView(contactVM: contactVM)
                    SortPickerView(contactVM : contactVM)
                    ContactListView(contactVM : contactVM)
                }
                .modifier(MainViewModifier(contactVM : contactVM))
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
