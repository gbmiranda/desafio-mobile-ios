//
//  RepositorioTableViewCell.swift
//  Desavio_appprova
//
//  Created by Gabriel Miranda on 11/04/17.
//  Copyright © 2017 Gabriel Miranda. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireImage

class RepositorioTableViewCell: UITableViewCell {

    @IBOutlet var imgOwner: UIImageView!
    @IBOutlet var nameOwner: UILabel!
    
    @IBOutlet var repoName: UILabel!
    @IBOutlet var repoDesc: UILabel!
    @IBOutlet var repoDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
    }

    func loadCell(repo: Repositorio){
    
        self.repoName.text = repo.full_name != nil ? repo.full_name! : ""
        self.repoDesc.text = repo.description != nil ? repo.description! : ""
        self.repoDetails.text = "Forks: \(repo.forks_count!) | Stars: \(repo.stargazers_count!)"
        
        self.nameOwner.text = repo.owner?.login != nil ? repo.owner?.login! : ""

        self.imageFromUrl(link: repo.owner!.avatar_url!)
        
    }
    
    func imageFromUrl(link: String? = nil){
        
        let url = URL(string: link!)
        
        self.imgOwner.af_setImage(withURL: url!, placeholderImage: UIImage(named: ""), filter: CircleFilter(), imageTransition: UIImageView.ImageTransition.crossDissolve(0.5))
        
    }
    
}
