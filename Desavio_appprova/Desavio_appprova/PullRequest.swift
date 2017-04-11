//
//  PullRequest.swift
//  Desavio_appprova
//
//  Created by Gabriel Miranda on 11/04/17.
//  Copyright © 2017 Gabriel Miranda. All rights reserved.
//

import ObjectMapper

public class PullRequest: Mappable {
    
    public var id: Int?
    public var title: String?
    public var body: String?
    public var url: String?
    public var created_at: String?

    public var owner: Owner?

    required public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.body <- map["body"]
        self.url <- map["html_url"]
        self.created_at <- map["created_at"]
        self.owner <- map["user"]
    }
    
}
