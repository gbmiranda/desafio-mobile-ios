//
//  BaseService.swift
//  desafio_mobile_hands_on
//
//  Created by Gabriel Miranda on 29/09/16.
//  Copyright © 2016 Gabriel Miranda. All rights reserved.
//

import Alamofire
import ObjectMapper

class BaseService: NSObject {
    
    var manager: Alamofire.SessionManager?
    
    public func startReachabilityMonitoring() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        manager = Alamofire.SessionManager(configuration: configuration)
        
    }
    
    internal func apiRequest(_ method: Alamofire.HTTPMethod, address: String, parameters: [String: Any]? = nil, completion: ((_ finished: Bool, _ response: AnyObject?) -> Void)? = nil) {
        
        let headers: [String: String] = [:]

        manager?.request(address, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            
            self.printInfo("Requisição: \(response.request!)")
            
//            self.printInfo("Retorno: \(response.response!.statusCode)")
            
            if let JSON = response.result.value {
                
//                self.printInfo(JSON)

                completion?(true, JSON as AnyObject?)

            } else {
                
                if response.response?.statusCode == 204{
                    completion?(true, nil)
                }else{
                    completion?(false, nil)
                }
                
            }
            
        })
        
    }

    func intervalToInt(timeInterval: TimeInterval) -> Int{
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        let timeStr = formatter.string(from: NSNumber(value: timeInterval))!
        return (formatter.number(from: timeStr)?.intValue)!
        
    }
    
    func printInfo(_ info: Any){
        print(info)
    }
    
}
