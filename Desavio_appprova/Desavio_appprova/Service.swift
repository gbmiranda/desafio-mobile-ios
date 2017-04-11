//
//  Service.swift
//  desafio_mobile_hands_on
//
//  Created by Gabriel Miranda on 29/09/16.
//  Copyright © 2016 Gabriel Miranda. All rights reserved.
//

import Alamofire
import ObjectMapper

class Service: BaseService {
    
    static let shared = Service()
    
    public override init() {
        super.init()
        
        self.startReachabilityMonitoring()
        
    }
    
    public func getRepositorios(pagina: String, completion: ((_ finished: Bool, _ response: BaseModel?) -> Void)? = nil) {
        
        self.apiRequest(.get, address: "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=\(pagina)", completion: { (finished, response) in
            
            var result: BaseModel?
            
            if response != nil{
                result = Mapper<BaseModel>().map(JSONObject: response)
            }
            
            completion?(finished, result)
            
        })
        
    }

    public func getPullRequest(address: String, completion: ((_ finished: Bool, _ response: [PullRequest]?) -> Void)? = nil) {
        
        self.apiRequest(.get, address: address, completion: { (finished, response) in
            
            var result: [PullRequest]?
            
            if response != nil{
                result = Mapper<PullRequest>().mapArray(JSONObject: response)
            }
            
            completion?(finished, result)
            
        })
        
    }
    
    

}
