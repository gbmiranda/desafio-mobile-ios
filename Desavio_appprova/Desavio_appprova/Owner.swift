//
//  Owner.swift
//  Desavio_appprova
//
//  Created by Gabriel Miranda on 11/04/17.
//  Copyright © 2017 Gabriel Miranda. All rights reserved.
//

import ObjectMapper

public class Owner: Mappable {
    
    public var id: Int?
    public var login: String?
    public var avatar_url: String?
    
    required public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        self.id <- map["id"]
        self.login <- map["login"]
        self.avatar_url <- map["avatar_url"]
    }
    
}
