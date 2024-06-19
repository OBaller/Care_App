//
//  BaseResponse.swift
//  Care_App
//
//  Created by Naseem Oyebola on 19/06/2024.
//

import Foundation

// MARK: - TaskResult
struct TaskResult: Codable {
  let status: String
  let code: Int
  let message: String
  let data: [Tasks]
}

// MARK: - Tasks
struct Tasks: Codable, Identifiable, Equatable {
  var id: Int {
    userID
  }
  let taskID, userID: Int
  let taskDetailRef, timeOfDay, supportLevel: String
  let hourOfDay, action, taskGroup, taskType: String?
  let order: Int
  let priority, supportPersonnel: String
  let numSupportPersonnel: Int
  let cron, taskDate, taskStartedOn, taskEndedOn: String?
  let workStatus: String
  let taskAssignments: [TaskAssignment]
  
  enum CodingKeys: String, CodingKey {
    case taskID = "taskId"
    case userID = "userId"
    case taskDetailRef, timeOfDay, hourOfDay, supportLevel, action, taskGroup, taskType, order, priority, supportPersonnel, numSupportPersonnel, cron, taskDate, taskStartedOn, taskEndedOn, workStatus, taskAssignments
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    // Use the helper function to decode fields
    taskID = try container.decodeFlexible(Int.self, forKey: .taskID)
    userID = try container.decodeFlexible(Int.self, forKey: .userID)
    taskDetailRef = try container.decode(String.self, forKey: .taskDetailRef)
    timeOfDay = try container.decode(String.self, forKey: .timeOfDay)
    hourOfDay = try container.decodeIfPresent(String.self, forKey: .hourOfDay)
    supportLevel = try container.decode(String.self, forKey: .supportLevel)
    action = try container.decodeIfPresent(String.self, forKey: .action)
    taskGroup = try container.decodeIfPresent(String.self, forKey: .taskGroup)
    taskType = try container.decodeIfPresent(String.self, forKey: .taskType)
    order = try container.decodeFlexible(Int.self, forKey: .order)
    priority = try container.decode(String.self, forKey: .priority)
    supportPersonnel = try container.decode(String.self, forKey: .supportPersonnel)
    numSupportPersonnel = try container.decodeFlexible(Int.self, forKey: .numSupportPersonnel)
    cron = try container.decodeIfPresent(String.self, forKey: .cron)
    taskDate = try container.decodeIfPresent(String.self, forKey: .taskDate)
    taskStartedOn = try container.decodeIfPresent(String.self, forKey: .taskStartedOn)
    taskEndedOn = try container.decodeIfPresent(String.self, forKey: .taskEndedOn)
    workStatus = try container.decode(String.self, forKey: .workStatus)
    taskAssignments = try container.decode([TaskAssignment].self, forKey: .taskAssignments)
  }
}

// MARK: - TaskAssignment
struct TaskAssignment: Codable, Equatable {
  let assignee: Assignee
  let assignmentStatus: String
}


// MARK: - Assignee
struct Assignee: Codable, Equatable {
  let userID: Int
  let firstName, lastName: String
  
  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case firstName, lastName
  }
}

