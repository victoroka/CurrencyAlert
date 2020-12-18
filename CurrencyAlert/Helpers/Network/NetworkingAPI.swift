//
//  NetworkingAPI.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 20/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: - Networking Service Protocol
protocol NetworkingService {
    @discardableResult func login(user: UserLoginViewModel, _ endpoint: Endpoint, completion: @escaping (Result<LoginResponse, LoginResponse>) -> Void) -> URLSessionDataTask?
    @discardableResult func register(user: UserCreateViewModel, _ endpoint: Endpoint, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) -> URLSessionDataTask?
    @discardableResult func fetchCurrencies(_ endpoint: Endpoint, completion: @escaping (Result<[Currency], NetworkError>) -> Void) -> URLSessionDataTask?
    @discardableResult func fetchAlerts(_ endpoint: Endpoint, completion: @escaping (Result<[Alert], NetworkError>) -> Void) -> URLSessionDataTask?
    @discardableResult func create(alert: CreateAlertViewModel, _ endpoint: Endpoint, completion: @escaping (Result<AlertRequestResponse, AlertRequestResponse>) -> Void) -> URLSessionDataTask?
    @discardableResult func delete(_ endpoint: Endpoint, completion: @escaping (Result<AlertRequestResponse, NetworkError>) -> Void) -> URLSessionDataTask?
}

final class NetworkingAPI: NetworkingService {
    private let session = URLSession.shared
    
    // MARK: - Login Request
    @discardableResult
    func login(user: UserLoginViewModel, _ endpoint: Endpoint, completion: @escaping (Result<LoginResponse, LoginResponse>) -> Void) -> URLSessionDataTask? {
        
        guard let url = endpoint.url else {
            completion(.failure(LoginResponse(message: Constants.badUrlErrorMessage, user: nil)))
            return nil
        }
        
        let parameters = [
            Constants.Parameters.email: user.email,
            Constants.Parameters.password: user.password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Request.Method.POST
        request.setValue(Constants.API_KEY, forHTTPHeaderField: Constants.Request.apiHeaderField)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(.failure(LoginResponse(message: Constants.mappingErrorMessage, user: nil)))
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if data == nil {
                completion(.failure(LoginResponse(message: Constants.emptyResponseErrorMessage, user: nil)))
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            switch statusCode {
            case 200:
                do {
                    let decodedResponseMessage = try JSONDecoder().decode(LoginResponse.self, from: data!)
                    completion(.success(decodedResponseMessage))
                } catch {
                    completion(.failure(LoginResponse(message: Constants.mappingErrorMessage, user: nil)))
                }
            case 401:
                do {
                    let decodedResponseMessage = try JSONDecoder().decode(LoginResponse.self, from: data!)
                    completion(.failure(LoginResponse(message: decodedResponseMessage.message, user: nil)))
                } catch {
                    completion(.failure(LoginResponse(message: Constants.mappingErrorMessage, user: nil)))
                }
            default:
                completion(.failure(LoginResponse(message: Constants.loginGenericError, user: nil)))
            }
            
        }
        task.resume()
        
        return task
    }
    
    // MARK: - Register Request
    @discardableResult
    func register(user: UserCreateViewModel, _ endpoint: Endpoint, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) -> URLSessionDataTask? {
        
        guard let url = endpoint.url else {
            completion(.failure(.badUrl))
            return nil
        }
        
        let parameters = [
            Constants.Parameters.email: user.email,
            Constants.Parameters.password: user.password,
            Constants.Parameters.firstName: user.firstName,
            Constants.Parameters.lastName: user.lastName,
            Constants.Parameters.phone: user.phone
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
    
    // MARK: - Fetch Currencies Request
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
    
    // MARK: - Fetch Alerts Request
    @discardableResult
    func fetchAlerts(_ endpoint: Endpoint, completion: @escaping (Result<[Alert], NetworkError>) -> Void) -> URLSessionDataTask? {
        
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
                    let decodedAlertList = try JSONDecoder().decode([Alert].self, from: data!)
                    completion(.success(decodedAlertList))
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
    
    // MARK: - Create Alerts Request
    @discardableResult
    func create(alert: CreateAlertViewModel, _ endpoint: Endpoint, completion: @escaping (Result<AlertRequestResponse, AlertRequestResponse>) -> Void) -> URLSessionDataTask? {
        
        guard let url = endpoint.url else {
            completion(.failure(AlertRequestResponse(message: Constants.badUrlErrorMessage)))
            return nil
        }
        
        let parameters: [String : Any] = [
            Constants.Parameters.code: alert.code,
            Constants.Parameters.currentValue: alert.currentCurrencyValue,
            Constants.Parameters.alertValue: alert.value
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Request.Method.POST
        request.setValue(Constants.API_KEY, forHTTPHeaderField: Constants.Request.apiHeaderField)
        request.setValue(UserDefaults.standard.string(forKey: Constants.AUTH_KEY), forHTTPHeaderField: Constants.Request.authorizationHeaderField)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(.failure(AlertRequestResponse(message: Constants.mappingErrorMessage)))
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if data == nil {
                completion(.failure(AlertRequestResponse(message: Constants.emptyResponseErrorMessage)))
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if 201 == statusCode {
                do {
                    let decodedResponseMessage = try JSONDecoder().decode(AlertRequestResponse.self, from: data!)
                    completion(.success(decodedResponseMessage))
                } catch {
                    completion(.failure(AlertRequestResponse(message: Constants.mappingErrorMessage)))
                }
            } else if 409 == statusCode {
                do {
                    let decodedResponseMessage = try JSONDecoder().decode(AlertRequestResponse.self, from: data!)
                    completion(.failure(AlertRequestResponse(message: decodedResponseMessage.message)))
                } catch {
                    completion(.failure(AlertRequestResponse(message: Constants.mappingErrorMessage)))
                }
            } else {
                completion(.failure(AlertRequestResponse(message: Constants.createAlertGenericError)))
            }
        }
        task.resume()
        
        return task
    }
    
    // MARK: - Delete Request Alerts
    @discardableResult
    func delete(_ endpoint: Endpoint, completion: @escaping (Result<AlertRequestResponse, NetworkError>) -> Void) -> URLSessionDataTask? {
        
        guard let url = endpoint.url else {
            completion(.failure(.badUrl))
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Request.Method.DELETE
        request.setValue(Constants.API_KEY, forHTTPHeaderField: Constants.Request.apiHeaderField)
        request.setValue(UserDefaults.standard.string(forKey: Constants.AUTH_KEY), forHTTPHeaderField: Constants.Request.authorizationHeaderField)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if data == nil {
                completion(.failure(.emptyResponseDataError))
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if 200 == statusCode {
                do {
                    let decodedResponseMessage = try JSONDecoder().decode(AlertRequestResponse.self, from: data!)
                    completion(.success(decodedResponseMessage))
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
}
