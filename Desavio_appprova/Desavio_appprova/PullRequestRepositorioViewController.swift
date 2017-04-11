//
//  PullRequestRepositorioViewController.swift
//  Desavio_appprova
//
//  Created by Gabriel Miranda on 11/04/17.
//  Copyright © 2017 Gabriel Miranda. All rights reserved.
//

import UIKit
import SVProgressHUD

class PullRequestRepositorioViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var tableItens: [PullRequest] = []

    var repositorio: Repositorio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = repositorio.full_name!
        
        self.configuraTableView()
        
        if repositorio.pull_request != nil{
            self.tableItens = self.repositorio.pull_request!
        }else{
            self.buscarPullRequest()
        }
        
    }
    
    func buscarPullRequest(){

        SVProgressHUD.show(withStatus: "Buscando")

        Service.shared.getPullRequest(address: "https://api.github.com/repos/\(self.repositorio.full_name!)/pulls") { (success, baseData) in
            
            if success{
                
                if baseData != nil && baseData?.count != 0{
                    
                    self.repositorio.pull_request = baseData!
                    self.tableItens = baseData!
                    self.tableView.reloadData()

                }else{
                    
                    let alert = UIAlertController(title: "Atenção", message: "Nenhum Pull Request para este repositório", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            
            }else{
                print("ERRO")
            }
            
            SVProgressHUD.dismiss()
            
        }
        
    }
    
    func configuraTableView(){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.white
        
    }

}

extension PullRequestRepositorioViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pr = self.tableItens[indexPath.row]
        
        UIApplication.shared.open(URL(string: pr.url!)!, options: ["":""], completionHandler: nil)
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItens.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPullRequest", for: indexPath) as! PullRequestTableViewCell
        
        cell.loadCell(pr: tableItens[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}
