//
//  MangaObject.swift
//  MangoObjectSwiftJSON
//
//  Created by Blake Harrison on 2/11/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation
import SwiftyJSON

var chapterArray = [MangaChapter]()

struct MangaChapter {
    var number: String
    var title: String
    var id: String
    
    init(number: String, title: String, id: String) {
        self.number = number
        self.title = title
        self.id = id
    }
}


