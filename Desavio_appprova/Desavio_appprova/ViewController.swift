//
//  ViewController.swift
//  Desavio_appprova
//
//  Created by Gabriel Miranda on 11/04/17.
//  Copyright © 2017 Gabriel Miranda. All rights reserved.
//

import UIKit
import ObjectMapper
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tableItens: [Repositorio] = []
    
    var pagina = 1
    
    var acabou = false
    var controleBuscaMais = true

    var repositorioSelecionado: Repositorio?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Repositórios"
        
        self.configuraTableView()
        
        self.buscarRepositorios()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "seguePullRequest"{
            
            let vc = segue.destination as! PullRequestRepositorioViewController
            vc.repositorio = self.repositorioSelecionado
            
        }
        
    }
    
    func configuraTableView(){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.white
        
    }
    
    func buscarRepositorios(){
        
        SVProgressHUD.show(withStatus: "Buscando")
        
        Service.shared.getRepositorios(pagina: "\(pagina)") { (success, baseData) in
            
            if success{
                
                if baseData != nil && baseData?.items != nil{
                    
                    self.tableItens.append(contentsOf: baseData!.items!)
                    
                    self.tableView.reloadData()
                    
                    self.pagina += 1
                    
                }else{
                    self.acabou = true
                }
                
            }else{
                print("ERRO")
            }
            
            self.controleBuscaMais = true
            SVProgressHUD.dismiss()
            
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.repositorioSelecionado = self.tableItens[indexPath.row]
        
        self.performSegue(withIdentifier: "seguePullRequest", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItens.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRepositorio", for: indexPath) as! RepositorioTableViewCell
        
        cell.loadCell(repo: tableItens[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}

extension ViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let actualPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - self.tableView.frame.height
        
        if actualPosition >= contentHeight{
            
            if controleBuscaMais == true && acabou == false{
                self.controleBuscaMais = false
                self.buscarRepositorios()
            }
            
        }
        
    }
    
}
