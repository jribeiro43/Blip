//
//  AlbumViewController.swift
//  Blip_app
//
//  Created by João Ribeiro on 26/05/2022.
//

import UIKit
import Kingfisher

class AlbumViewController: UIViewController {
    
    var image: String = ""
    var album: String = ""
    var artist: String = ""

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var tracks: UILabel!
    @IBOutlet weak var publish: UILabel!
    @IBOutlet weak var listeners: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
        
        self.loadData()
        
        self.view.isUserInteractionEnabled = true
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
        self.loadInfoData(albumName: self.album, artistName: self.artist, handler: { () in
            group.leave()
        })
        
        group.notify(queue: .main) {
            self.navigationItem.title = "Album Details"
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                // then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
    }
    
    func loadInfoData(albumName: String, artistName: String, handler: @escaping () -> Void) {
        WebApiManager.sharedInstance.getAlbumData(artist: artistName, method: "album.getinfo", album: albumName) { albumData in
            
            self.albumImage.kf.setImage(with: URL(string: self.image))
            self.albumName.text = albumData.albumName
            self.artistName.text = albumData.artistName
            self.listeners.text = "Total Listeners: " + albumData.listeners
            self.tracks.text = "Album Tracks: " + "\(albumData.tracksCount)"
            
            if albumData.publishDate.isEmpty == false {
                let date = albumData.publishDate.split(separator: ",")
                self.publish.text = "Publish: " + String(date[0])
            } else {
                self.publish.isHidden = true
            }
            
            handler()
        }
    }

}
