//
//  NetworkManager.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation


// MARK: - Networking
protocol Networking {
    func request<T: Codable>(request: RequestModel, completion: @escaping (Result<T, ApiError>) -> Void)
}

// MARK: - NetowrkManager
final class NetworkManager: Networking {
    
    // MARK: Properties
    /// Shared url session
    private let session: URLSession
    
    // MARK: Init
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Use this function to making a network call request
    /// - Parameters:
    ///   - request:  Any model that confirms `RequestModel`
    ///   - completion: Escaping closure
    func request<T: Codable>(request: RequestModel, completion: @escaping (Result<T, ApiError>) -> Void) {
        LoadingManager.shared.show()
        
        guard let generatedRequest = request.generateRequest() else {
            LoadingManager.shared.hide()
            completion(.failure(.badRequest))
            return
        }
        
        let task = session.dataTask(with: generatedRequest) { data, response, error in
            LoadingManager.shared.hide()
            
            if error != nil || data == nil { completion(.failure(.unknownError)) }
            
            if let apiEror = self.returnResponseErorIfNeeded(response: response) {
                completion(.failure(apiEror))
            }
            
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(.unknownError))
            }
            
        }
        
        task.resume()
    }
}

// MARK: - Helpers
private extension NetworkManager {
    func returnError(with responseCode: Int) -> ApiError {
        switch responseCode {
        case 400:
            return .notFound
        case 403:
            return .unknownError
        case 408:
            return .timeOut
        case 500:
            return .serverError
        default:
            return .unknownError
        }
    }
    
    func returnResponseErorIfNeeded(response: URLResponse?) -> ApiError? {
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            return returnError(with: httpResponse.statusCode)
        }
        
        return nil
    }
}
