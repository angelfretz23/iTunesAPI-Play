//
//  SongController.swift
//  itunesAPI
//
//  Created by Angel Contreras on 9/7/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class SongController {
    
    static let baseURL = NSURL(string: "https://itunes.apple.com/search?")
    
    static func fetchSongs(term: String, completion: (songs: [Song]) -> Void){
        let urlParameters = ["entity": "musicTrack", "term": term]
        
        guard let url = baseURL else { completion(songs: []); return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
            guard let data = data, responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                else { completion(songs: []); return }
            
            if error != nil{
                print(error?.localizedDescription)
            } else if responseDataString.containsString("error"){
                print("Error: \(responseDataString)")
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String:AnyObject], resultDictionary = jsonDictionary["results"] as? [[String: AnyObject]]
                else { completion(songs: []); return }
            
            let songs = resultDictionary.flatMap({Song(dictionary: $0)})
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(songs: songs)
            })
        }
    }
}