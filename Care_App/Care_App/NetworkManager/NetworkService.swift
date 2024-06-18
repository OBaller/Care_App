//
//  NetworkService.swift
//  Care_App
//
//  Created by Naseem Oyebola on 18/06/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func login(userName: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://api.staging.caresaas.co.uk/caresaas/v1/services/auth/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: String] = ["userName": userName, "password": password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                let token = loginResponse.data.userToken.accessToken
                completion(.success(token))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
