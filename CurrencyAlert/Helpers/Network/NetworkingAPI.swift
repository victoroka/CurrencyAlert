//
//  NetworkingAPI.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 20/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

protocol NetworkingService {
    @discardableResult func fetchCurrencies(_ endpoint: Endpoint, completion: @escaping (Result<[Currency], NetworkError>) -> Void) -> URLSessionDataTask?
    @discardableResult func register(user: UserCreateViewModel, _ endpoint: Endpoint, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) -> URLSessionDataTask?
    @discardableResult func login(user: UserLoginViewModel, _ endpoint: Endpoint, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) -> URLSessionDataTask?
}

final class NetworkingAPI: NetworkingService {
    private let session = URLSession.shared
    
    @discardableResult
    func fetchCurrencies(_ endpoint: Endpoint, completion: @escaping (Result<[Currency], NetworkError>) -> Void) -> URLSessionDataTask? {
        
        guard let url = endpoint.url else {
            completion(.failure(.badUrl))
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Request.Method.GET
        request.setValue(Constants.API_KEY, forHTTPHeaderField: Constants.Request.apiHeaderField)
        request.setValue(UserDefaults.standard.string(forKey: Constants.AUTH_KEY), forHTTPHeaderField: Constants.Request.authorizationHeaderField)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if data == nil {
                completion(.failure(.emptyResponseDataError))
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if 200...299 ~= statusCode {
                do {
                    let decodedCurrencyList = try JSONDecoder().decode([Currency].self, from: data!)
                    completion(.success(decodedCurrencyList))
                } catch {
                    completion(.failure(.mappingError))
                }
            } else {
                completion(.failure(NetworkHelper.getErrorDescription(for: statusCode)))
            }
        })
        task.resume()
        
        return task
    }
    
    @discardableResult
    func register(user: UserCreateViewModel, _ endpoint: Endpoint, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) -> URLSessionDataTask? {
        
        guard let url = endpoint.url else {
            completion(.failure(.badUrl))
            return nil
        }
        
        let parameters = [
            CreateAccountStrings.emailPostProperty.rawValue: user.email,
            CreateAccountStrings.passwordPostProperty.rawValue: user.password,
            CreateAccountStrings.firstNamePostProperty.rawValue: user.firstName,
            CreateAccountStrings.lastNamePostProperty.rawValue: user.lastName,
            CreateAccountStrings.phonePostProperty.rawValue: user.phone
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Request.Method.POST
        request.setValue(Constants.API_KEY, forHTTPHeaderField: Constants.Request.apiHeaderField)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(.failure(.mappingError))
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if data == nil {
                completion(.failure(.emptyResponseDataError))
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if 200...299 ~= statusCode {
                do {
                    let decodedResponseMessage = try JSONDecoder().decode(CreateAccountResponse.self, from: data!)
                    completion(.success(decodedResponseMessage))
                } catch {
                    completion(.failure(.mappingError))
                }
            } else {
                completion(.failure(NetworkHelper.getErrorDescription(for: statusCode)))
            }
        }
        task.resume()
        
        return task
    }
    
    @discardableResult
    func login(user: UserLoginViewModel, _ endpoint: Endpoint, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) -> URLSessionDataTask? {
        
        guard let url = endpoint.url else {
            completion(.failure(.badUrl))
            return nil
        }
        
        let parameters = [
            LoginStrings.emailPostProperty.rawValue: user.email,
            LoginStrings.passwordPostProperty.rawValue: user.password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Request.Method.POST
        request.setValue(Constants.API_KEY, forHTTPHeaderField: Constants.Request.apiHeaderField)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(.failure(.mappingError))
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if data == nil {
                completion(.failure(.emptyResponseDataError))
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if 200 == statusCode {
                do {
                    let decodedResponseMessage = try JSONDecoder().decode(CreateAccountResponse.self, from: data!)
                    completion(.success(decodedResponseMessage))
                } catch {
                    completion(.failure(.mappingError))
                }
            } else {
                completion(.failure(NetworkHelper.getErrorDescription(for: statusCode)))
            }
        }
        task.resume()
        
        return task
    }
}
