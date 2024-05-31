//
//  TaskView.swift
//  TaskManager
//
//  Created by Mohammad Yasir on 13/04/21.
//

import SwiftUI

struct ContactView: View {
    
    @ObservedObject var contactVM : ContactViewModel
    var contact : Contact
    
    var body: some View {
        VStack (alignment : .leading){
            HStack{
                VStack(alignment:.leading) {
                    Text("Name:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(contact.name)
                        .font(.system(size: 20, weight: .bold))
                }
                Spacer()
                VStack (alignment:.leading){
                    if(contact.birthDay != nil) {
                        Text("Birthday in")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(contact.daysUntilNextBirthDay ?? 0) + " days")
                            .font(.system(size: 20, weight: .bold))
                    }
                }
            }
            if(contact.daysUntilClosestDateToRememberString.count > 0) {
                Text("Next important event is")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(contact.daysUntilClosestDateToRememberString)
                    .font(.system(size: 15, weight: .bold))
                    .italic()
            }
        }
        .onTapGesture {
            print(contact.name)
        }
        .padding(10)
        .background(
            contact.importance.color.opacity(0.2))
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10 , style: .continuous)
                .stroke(contact.importance.color , lineWidth: 0.7)
                .shadow(color: contact.importance.color, radius: 0.7))
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(contactVM: ContactViewModel(), contact: Contact(id: "", name: "Name", gender: .male, birthDay: convertStringToDate(dateString: "1985-03-20"), datesToRemember: [DateToRemember(title: "Special Day", date: convertStringToDate(dateString: "2025-04-30"))],  interests: "", relationship: .friend, importance: .high, address: "", city: "", state: "", zipCode: ""))
    }
}
