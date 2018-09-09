//
//  Networking.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 8/16/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

// https://www.mangaeden.com/api/list/0/ List of all manga in JSON
// let mangaEdenURL = "https://www.mangaeden.com/api"

import UIKit
import SwiftyJSON

public var imageStringForCover: String = ""

//Manga list - https://www.mangaeden.com/api/list/0/

class MangoNetworking {
    
    //MARK: - Properties
    let mangaImageURL = "https://cdn.mangaeden.com/mangasimg/"
    let mangeListURL = "https://www.mangaeden.com/api/manga/"
    let mangaChapterURL = "https://www.mangaeden.com/api/chapter/"
    
    var fetchedPagesURLs: Array<String> = []
    
    //MARK: - Methods
    func fetchMangaChapterInfo(chapterID: String) {
        guard let url = URL(string: mangaChapterURL + chapterID) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Reponse Error")
            return }
            do{
                //here dataResponse received from a network request
                _ = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])

                let json = try JSON(data: data!)
                
                let imageArray = json["images"].array!

                if imageArray.count != 0 {
                    resultsArray.removeAll()
                    for n in 0...imageArray.count - 1 {
                        self.fetchedPagesURLs.append(self.mangaImageURL + imageArray[n][1].string!)
                    }
                }
                
                print(self.fetchedPagesURLs)
               
                NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func fetchMangaTitles(searchedManga: String) {
        guard let url = URL(string: "https://www.mangaeden.com/api/list/0/") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                _ = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                let decoder = JSONDecoder()
                
                let listOfMangas = try decoder.decode(MangaList.self, from: data!)
                
                let filteredManga = listOfMangas.manga.filter { ($0.t?.contains(searchedManga))! }
                
                searchedMangaList = filteredManga
                
                if filteredManga.count != 0 {
                    
                    resultsArray.removeAll()
                    
                    for n in 0...filteredManga.count - 1 {
                        resultsArray.append(filteredManga[n].t!)
                    }
                    
                } else {
                    print("Manga Not Found")
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
}
