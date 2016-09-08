//
//  Song.swift
//  itunesAPI
//
//  Created by Angel Contreras on 9/7/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

struct Song {
    let songName: String
    let artist: String
    let album: String
    let artwork: String
    let previewURL: String
    
    private let kSongName = "trackName"
    private let kArtist = "artistName"
    private let kAlbum = "collectionName"
    private let kArtwork = "artworkUrl60"
    private let kPreviewURL = "previewUrl"
}

extension Song {
    
    init?(dictionary: [String: AnyObject]){
        guard let songName = dictionary[kSongName] as? String,
        artist = dictionary[kArtist] as? String,
        album = dictionary[kAlbum] as? String,
        artwork = dictionary[kArtwork] as? String,
        previewURL = dictionary[kPreviewURL] as? String
            else { return nil }
        
        self.songName = songName
        self.artist = artist
        self.album = album
        self.artwork = artwork
        self.previewURL = previewURL
    }
}