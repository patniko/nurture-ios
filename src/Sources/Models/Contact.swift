import Foundation
import SwiftUI

struct Contact : Identifiable , Equatable, Codable {
    var id : String = UUID().uuidString
    let name : String
    let gender : Gender?
    let birthDay : Date?
    let datesToRemember : [DateToRemember]?
    let interests : String?
    let relationship : Relationship
    let importance : Importance
    let address : String?
    let city : String?
    let state : String?
    let zipCode : String?
    
    var daysUntilNextBirthDay : Int? {
        return birthDay != nil ? findDaysUntilNextEvent(date: birthDay!) : nil
    }
    
    var daysUntilClosestDateToRemember : DateToRemember? {
        if(datesToRemember != nil) {
            let date: DateToRemember? = findClosestDateToRemember(dates: datesToRemember!)
            return date
        } else {
            return nil
        }
    }
    
    var daysUntilClosestDateToRememberString : String {
        let closestEvent = daysUntilClosestDateToRemember
        if(closestEvent != nil)
        {
            return String(closestEvent!.daysUntilNextEvent) + String(" days until " + closestEvent!.title)
        }
        else
        {
            return ""
        }
    }
}

struct DateToRemember : Identifiable, Equatable, Codable {
    var id : String = UUID().uuidString
    let title : String
    let date : Date

    var daysUntilNextEvent : Int {
        return findDaysUntilNextEvent(date: date)
    }
}

enum Gender : Int , Identifiable , CaseIterable, Codable {
    var id : Int { rawValue }
    
    case notSpecified
    case male
    case female
    case nonbinary
    case intersex
    
    var title : String {
        switch self {
            case .notSpecified :
                return "Not Specified"
            case .male :
                return "Male"
            case .female :
                return "Female"
            case .nonbinary :
                return "Non-Binary"
            case .intersex :
                return "Intersex"
        }
    }
}

enum Relationship : Int , Identifiable , CaseIterable, Codable {
    var id : Int { rawValue }
    
    case significantOther
    case spouse
    case friend
    case parent
    case sibling
    
    var title : String {
        switch self {
            case .significantOther :
                return "Significant Other"
            case .spouse :
                return "Spouse"
            case .friend :
                return "Friend"
            case .parent :
                return "Parent"
            case .sibling :
                return "Sibling"
        }
    }
}

enum Importance : Int , Identifiable , CaseIterable, Codable {
    var id : Int { rawValue }
    
    case normal
    case medium
    case high
    
    var title : String {
        switch self {
            case .normal :
                return "Normal"
            case .medium :
                return "Medium"
            case .high :
                return "High"
        }
    }
    
    var color : Color {
        switch self {
            case .normal:
                return .white
            case .medium:
                return .orange
            case .high :
                return .red
        }
    }
}

enum SortType : String , Identifiable , CaseIterable {

    var id : String { rawValue }
    
    case name
    case birthDay
    case importance
    
    var title : String {
        switch self {
            case .name :
                return "Name"
            case .birthDay :
                return "Birthday"
            case .importance :
                return "Importance"
        }
    }
}
