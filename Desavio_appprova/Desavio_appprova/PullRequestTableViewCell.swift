//
//  PullRequestTableViewCell.swift
//  Desavio_appprova
//
//  Created by Gabriel Miranda on 11/04/17.
//  Copyright © 2017 Gabriel Miranda. All rights reserved.
//

import UIKit
import AlamofireImage

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet var imgOwner: UIImageView!
    @IBOutlet var usernameOwner: UILabel!
    
    @IBOutlet var prTitle: UILabel!
    @IBOutlet var prBody: UILabel!
    @IBOutlet var prData: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func loadCell(pr: PullRequest){
        
        self.prTitle.text = pr.title != nil ? pr.title! : ""
        self.prBody.text = pr.body != nil ? pr.body! : ""
        self.prData.text = pr.created_at != nil ? pr.created_at! : ""
        
        self.usernameOwner.text = pr.owner?.login != nil ? pr.owner?.login! : ""
        
        self.imageFromUrl(link: pr.owner!.avatar_url!)
        
    }
    
    func imageFromUrl(link: String? = nil){
        
        let url = URL(string: link!)
        
        self.imgOwner.af_setImage(withURL: url!, placeholderImage: UIImage(named: ""), filter: CircleFilter(), imageTransition: UIImageView.ImageTransition.crossDissolve(0.5))
        
    }

}
