//
//  NarutoPage12.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/10/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class NarutoPage12: MangaPageViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let currentPage = pageNumber + 11
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage(theUrl: mangaImages(manga: "Naruto", chapter: 109088, page: 12), theImageView: imageView)
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 2.5
        
        print(currentPage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        endOfChapter(currentPage: currentPage)
    }
    
    //MARK: Functions
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    //MARK: End of Chapter
    func endOfChapter(currentPage: Int) {
        if currentPage == pagesContainedInChapter(manga: "Naruto", chapter: 109088) {
            
            //ALERT
            let alertController = UIAlertController(title: "End", message: "Start next chapter?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { action in
                self.performSegue(withIdentifier: "Home", sender: self)
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Yes", style: .default) { action in
                print("Next Chapter Placeholder")
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                // ...
            }
            
        }
    }
}