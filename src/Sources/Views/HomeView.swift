//
//  ContentView.swift
//  TaskManager
//
//  Created by Mohammad Yasir on 13/04/21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var contactVM = ContactViewModel()
    
    @State var searched = ""
    
    var body: some View {
            NavigationView{
                VStack{
                    ContactListView(contactVM : contactVM)
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
