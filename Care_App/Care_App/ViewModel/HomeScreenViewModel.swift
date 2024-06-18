//
//  HomeScreenViewModel.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import Foundation

public struct HomeScreenViewModel {
  let medications: [MedsModel] = [
    .init(description: "11 Medications to take", name: "James", room: "RM 3A", bed: "Bed 5", time: "noon"),
    .init(description: "5 Medications to take", name: "Sandy", room: "RM 3A", bed: "Bed 45", time: "Afternoon"),
    .init(description: "3 Medications to take", name: "Yinka", room: "RM 2D", bed: "Bed 8", time: "07:55am"),
    .init(description: "12 Medications to take", name: "Ololade Ayinde", room: "RM 3A", bed: "Bed 45", time: "03:52pm"),
    .init(description: "9 Medications to take", name: "Uche", room: "RM 4B", bed: "Bed 93", time: "07:45pm"),
    .init(description: "22 Medications to take", name: "Carmen", room: "RM 6F", bed: "Bed 74", time: "09:00am"),
    .init(description: "200 Medications to take", name: "Cardozo", room: "RM 9G", bed: "Bed 22", time: "Morning"),
    .init(description: "53 Medications to take", name: "Nani", room: "RM 5A", bed: "Bed 89", time: "Afternoon")
  ]
  
  let activities: [MedsModel] = [
    .init(description: "200 Medications to take", name: "Cardozo", room: "RM 2B", bed: "Bed 20", time: "Morning"),
    .init(description: "53 Medications to take", name: "Nani", room: "RM 3A", bed: "Bed 01", time: "Afternoon"),
    .init(description: "12 Medications to take", name: "Ololade AYinde", room: "RM 3A", bed: "Bed 45", time: "03:52pm"),
    .init(description: "9 Medications to take", name: "Uche", room: "RM 4D", bed: "Bed 72", time: "07:45pm"),
    .init(description: "22 Medications to take", name: "Carmen", room: "RM 2C", bed: "Bed 43", time: "09:00am"),
  ]
}
