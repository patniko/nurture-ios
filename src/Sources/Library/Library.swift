//
//  Library.swift
//  LittleThings
//
//  Created by Patrick on 4/14/23.
//

import Foundation
import SwiftUI

func changeDateYearToNextEvent(date: Date) -> Date {
    let year = Calendar.current.component(.year, from: Date())
    let month = Calendar.current.component(.month, from: date)
    let day = Calendar.current.component(.day, from: date)
    let dateComponents = DateComponents(year: year, month: month, day: day)
    let date = Calendar.current.date(from: dateComponents) ?? Date()

    // Check if date is in the past and if so, add a year
    if date < Date() {
        let dateComponents = DateComponents(year: year + 1, month: month, day: day)
        let date = Calendar.current.date(from: dateComponents) ?? Date()
        return date
    }

    return date
}

func findClosestDateToRemember(dates: [DateToRemember]) -> DateToRemember? {
    var daysUntilNextEvent = 0
    var closestDate: DateToRemember? = nil
    for date in dates {
        let daysUntil = date.daysUntilNextEvent
        if daysUntilNextEvent == 0 {
            daysUntilNextEvent = daysUntil
            closestDate = date
        } else if daysUntil < daysUntilNextEvent {
            daysUntilNextEvent = daysUntil
            closestDate = date
        }
    }
    return closestDate
}

func closestDaysUntilNextEvent(dates: [Date]) -> Int? {
    var daysUntilNextEvent = 0
    for date in dates {
        let daysUntil = findDaysUntilNextEvent(date: date)
        if daysUntilNextEvent == 0 {
            daysUntilNextEvent = daysUntil
        } else if daysUntil < daysUntilNextEvent {
            daysUntilNextEvent = daysUntil
        }
    }
    return daysUntilNextEvent
}

func findDaysUntilNextEvent(date: Date) -> Int {
    let dateCurrentYear = changeDateYearToNextEvent(date: date)
    let daysUntilNextEvent = daysBetween(start: Date(), end: dateCurrentYear)
    return daysUntilNextEvent
}

func daysBetween(start: Date, end: Date) -> Int {
    return Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
}

func convertStringToDate(dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: dateString)
    return date!
}

