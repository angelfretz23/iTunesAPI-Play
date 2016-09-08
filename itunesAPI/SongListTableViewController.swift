//
//  SongListTableViewController.swift
//  itunesAPI
//
//  Created by Angel Contreras on 9/7/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit
import AVFoundation

class SongListTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var songPlayer = AVPlayer()
    
    var songs: [Song] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("songCell", forIndexPath: indexPath) as? SongTableViewCell

        let song = self.songs[indexPath.row]
        cell?.updateWithSong(song)

        return cell ?? SongTableViewCell()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        guard let term = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        SongController.fetchSongs(term) { (songs) in
            self.songs = songs
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let url = NSURL(string: self.songs[indexPath.row].previewURL)
        
        let songToPlay = AVPlayerItem(URL: url!)
        songPlayer = AVPlayer(playerItem: songToPlay)
        songPlayer.rate = 1.0
        songPlayer.play()
    }
}