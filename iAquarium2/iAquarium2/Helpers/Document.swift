//
//  Document.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 24/12/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import Foundation
import Firebase

class Document {
    let database = Firestore.firestore()
    var key: String
    
    init(key: String) {
        self.key = key
    }
}
