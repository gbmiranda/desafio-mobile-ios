//
//  BaseModel.swift
//  desafio_mobile_hands_on
//
//  Created by Gabriel Miranda on 29/09/16.
//  Copyright © 2016 Gabriel Miranda. All rights reserved.
//

import ObjectMapper

public class BaseModel: Mappable {

    public var total_count: Int?
    public var incomplete_results: Bool?
    public var items: [Repositorio]?

    required public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        self.total_count <- map["total_count"]
        self.incomplete_results <- map["incomplete_results"]
        self.items <- map["items"]
    }
    
}
