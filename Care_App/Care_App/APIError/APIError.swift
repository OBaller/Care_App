//
//  APIError.swift
//  Care_App
//
//  Created by Naseem Oyebola on 19/06/2024.
//

import Foundation
struct ErrorResponse: Codable {
  let status: String
  let code: Int
  let message: String
}
