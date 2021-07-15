//
//  SampleNetworking.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 15/07/21.
//  Copyright © 2021 Alerta Câmbio. All rights reserved.
//

import Foundation

typealias ServiceSuccessHandler = (() -> Swift.Void)
typealias ServiceFailureHandler = ((NetworkError) -> Swift.Void)

class ViewControllerSample {
    
    private func serviceSuccessHandler() -> ServiceSuccessHandler {
        return {
            // Do stuff
        }
    }
    
    private func serviceFailureHandler() -> ServiceFailureHandler {
        return { error in
            // Do stuff
        }
    }
}

class ViewModelSample {
    
    private var data: Data = Data()
    
    func fetchData(completion: @escaping ServiceSuccessHandler, failure: @escaping ServiceFailureHandler) {
        ServiceSample.shared.fetchData { (response) in
            guard let data = response as? Data else {
                failure(NetworkError.emptyResponseDataError)
                return
            }
            self.data = data
            // Do stuff
            completion()
        } failure: { (error) in
            failure(error)
        }

    }
}

class ServiceSample {
    
    static let shared = ServiceSample()
    
    func fetchData(success: ((_ root: Any) -> Void)?, failure: ((NetworkError) -> Void)?) {
        // Make request
    }
    
    func fetchData(_ completionHandler: @escaping (Result<Data, Error>) -> Void) {
        // Make request
    }
}
