//
//  ViewController.swift
//  Blip_app
//
//  Created by João Ribeiro on 25/05/2022.
//

import UIKit
import SwiftyJSON
import Kingfisher
import StoreKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var albums = GeneralAlbum()
    var items: Int = 0
    var limit: Int = 100
    var appView: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentCount = UserDefaults.standard.integer(forKey: "asd")
        
        if currentCount%10 == 0 {
            SKStoreReviewController.requestReview()
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.view.isUserInteractionEnabled = false
        self.tableView.isHidden = true
        
        self.loadData()
        
        self.view.isUserInteractionEnabled = true
        self.tableView.isHidden = false
    }
    
    func loadData() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        let group = DispatchGroup()
        
        group.enter()
        self.loadAlbumsData(limitAlbuns: self.limit, handler: { () in
            group.leave()
        })
        
        group.notify(queue: .main) {
            self.navigationItem.title = "“Hip Hop” Top 1000 Albums"
            self.tableView.reloadData()

            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                // then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
    }
    
    func loadAlbumsData(limitAlbuns: Int, handler: @escaping () -> Void) {
        WebApiManager.sharedInstance.getApiData(limit: limitAlbuns, method: "tag.gettopalbums", tag: "hiphop") { result in
            self.albums = result
            self.items = self.albums.albums[0].albumDetails.count

            handler()

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.albums.albums.isEmpty {
            return 0
        } else {
            return self.items
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        cell.albumImage.image = cell.albumImage.image?.withRenderingMode(.alwaysTemplate)
        cell.albumImage.tintColor = UIColor.black
        
        if self.traitCollection.userInterfaceStyle == .dark {
            cell.albumImage.tintColor = UIColor.white

        }

        if self.albums.albums.isEmpty == false {
            cell.albumTitle.text = self.albums.albums[0].albumDetails[indexPath.row].name
            
            for i in 0..<self.albums.albums[0].albumDetails[indexPath.row].imageDetails.count {
                let size = self.albums.albums[0].albumDetails[indexPath.row].imageDetails[i].size
                
                if size == "extralarge" {
                    cell.albumImage.kf.setImage(with: URL(string:self.albums.albums[0].albumDetails[indexPath.row].imageDetails[i].url))
                }
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.albums.albums.isEmpty == false && indexPath.row + 1 == self.limit {
            if self.limit < 1000 {
                self.limit = self.limit+100
                self.loadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AlbumViewController") as! AlbumViewController
        nextViewController.artist = self.albums.albums[0].albumDetails[indexPath.row].artist
        nextViewController.album = self.albums.albums[0].albumDetails[indexPath.row].name
        self.navigationController?.pushViewController(nextViewController , animated: true)
        
    }
}

public class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)

    public override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
