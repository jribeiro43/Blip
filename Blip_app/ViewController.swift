//
//  ViewController.swift
//  Blip_app
//
//  Created by João Ribeiro on 25/05/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        
//        self.tableView?.reloadData()
    }
    func loadData() {
        WebApiManager.sharedInstance.getApiData(limit: 1, method: "tag.gettopalbums", tag: "limit") { result in
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        cell.albumImage.image = cell.albumImage.image?.withRenderingMode(.alwaysTemplate)
        cell.albumImage.tintColor = UIColor.black


        if self.traitCollection.userInterfaceStyle == .dark {
            
            cell.albumImage.tintColor = UIColor.white

        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }

}

