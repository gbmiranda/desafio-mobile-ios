//
//  Repositorio.swift
//  Desavio_appprova
//
//  Created by Gabriel Miranda on 11/04/17.
//  Copyright © 2017 Gabriel Miranda. All rights reserved.
//

import ObjectMapper

public class Repositorio: Mappable {
    public required /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    init?(map: Map) {
        
    }
    
    public var id: Int?
    public var full_name: String?
    public var description: String?
    public var forks_count: Int?
    public var stargazers_count: Int?

    public var pulls_url: String?
    
    public var pull_request: [PullRequest]?
    public var owner: Owner?
        
    public func mapping(map: Map) {
        self.id <- map["id"]
        self.full_name <- map["full_name"]
        self.description <- map["description"]
        self.forks_count <- map["forks_count"]
        self.stargazers_count <- map["stargazers_count"]
        self.pulls_url <- map["pulls_url"]
        self.owner <- map["owner"]
    }
    
}
