//
//  SongTableViewCell.swift
//  itunesAPI
//
//  Created by Angel Contreras on 9/7/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit
import AVFoundation

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var albumArtwork: UIImageView!
    
    func updateWithSong(song: Song){
        songNameLabel.text = song.songName
        artistLabel.text = song.artist
        albumLabel.text = song.album
        
        ImageController.imageForURL(song.artwork) { (image) in
            self.albumArtwork.image = image
        }
    }
}