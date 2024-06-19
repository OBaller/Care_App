//
//  NetworkManager.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import Foundation

class NetworkManager {
  static let shared = NetworkManager()
  
  private init() {}
  
  // MARK: - Login Request
  func login(userName: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    let urlString = "https://api.staging.caresaas.co.uk/caresaas/v1/services/auth/login"
    let payload: [String: String] = ["userName": userName, "password": password]
    
    fetchGenericJSON(head: .noHeader, token: nil, header: nil, urlString: urlString, method: "POST", body: payload, queryItems: nil) { (result: Result<LoginResponse, Error>) in
      switch result {
        case .success(let loginResponse):
          let data = loginResponse.data.user
          let token = loginResponse.data.userToken.accessToken
          KeychainHelper.shared.set(token, forKey: "authToken")
          completion(.success(data))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  // MARK: - Fetch user services/task
  func fetchTasks(shortCode: String, careHomeId: String, completion: @escaping (Result<TaskResult, Error>) -> Void) {
    let urlString = "https://api.staging.caresaas.co.uk/caresaas/v1/services/tasks/\(shortCode)/careHome/\(careHomeId)"
    let queryItems = [URLQueryItem(name: "assignee", value: "15")]
    
    guard let token = KeychainHelper.shared.get("authToken") else {
      completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
      return
    }
    
    fetchGenericJSON(head: .header, token: token, header: "Authorization", urlString: urlString, method: "GET", body: nil, queryItems: queryItems) { (result: Result<TaskResult, Error>) in
      switch result {
        case .success(let response):
          print(response)
          completion(.success(response))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  // MARK: - Generic function to make network requests
  func fetchGenericJSON<T: Decodable>(
    head: Token,
    token: String?,
    header: String?,
    urlString: String,
    method: String = "GET",
    body: [String: Any]? = nil,
    queryItems: [URLQueryItem]? = nil,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    var components = URLComponents(string: urlString)
    components?.queryItems = queryItems
    
    guard let url = components?.url else {
      completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    
    if let body = body {
      do {
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
      } catch {
        completion(.failure(error))
        return
      }
    }
    
    if head == .header, let token = token, let header = header {
      request.setValue("Bearer \(token)", forHTTPHeaderField: header)
    }
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let data = data else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
        return
      }
      if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
        print("JSON Response: \(json)")
      } else {
        print("Failed to serialize JSON")
      }
      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let objects = try decoder.decode(T.self, from: data)
        completion(.success(objects))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}

enum Token {
  case header
  case noHeader
}
