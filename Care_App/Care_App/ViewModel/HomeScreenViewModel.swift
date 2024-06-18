//
//  HomeScreenViewModel.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import Foundation

public struct HomeScreenViewModel {
  let medications: [MedsModel] = [
    .init(description: "4 Medications to take", name: "James", room: "RM 3A", bed: "Bed 45", time: "noon"),
    .init(description: "5 Medications to take", name: "Sandy", room: "RM 3A", bed: "Bed 45", time: "Afternoon"),
    .init(description: "3 Medications to take", name: "Yinka", room: "RM 3A", bed: "Bed 45", time: "07:55am"),
    .init(description: "12 Medications to take", name: "Ololade AYinde", room: "RM 3A", bed: "Bed 45", time: "03:52pm"),
    .init(description: "9 Medications to take", name: "Uche", room: "RM 3A", bed: "Bed 45", time: "07:45pm"),
    .init(description: "22 Medications to take", name: "Carmen", room: "RM 3A", bed: "Bed 45", time: "09:00am"),
    .init(description: "200 Medications to take", name: "Cardozo", room: "RM 3A", bed: "Bed 45", time: "Morning"),
    .init(description: "53 Medications to take", name: "Nani", room: "RM 3A", bed: "Bed 45", time: "Afternoon")
  ]
  
  let activities: [MedsModel] = [
    .init(description: "200 Medications to take", name: "Cardozo", room: "RM 3A", bed: "Bed 45", time: "Morning"),
    .init(description: "53 Medications to take", name: "Nani", room: "RM 3A", bed: "Bed 45", time: "Afternoon"),
    .init(description: "12 Medications to take", name: "Ololade AYinde", room: "RM 3A", bed: "Bed 45", time: "03:52pm"),
    .init(description: "9 Medications to take", name: "Uche", room: "RM 3A", bed: "Bed 45", time: "07:45pm"),
    .init(description: "22 Medications to take", name: "Carmen", room: "RM 3A", bed: "Bed 45", time: "09:00am"),
  ]
}
