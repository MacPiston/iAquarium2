//
//  UserDocument.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 24/12/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import Foundation
import Firebase

class UserDocument {
    var email: String?
    var displayName: String?
    var userRef: DocumentReference?
    
    let database = Firestore.firestore()
    var uid: String
    
    init(uid: String) {
        self.uid = uid
        self.userRef = database.collection("users").document(self.uid)
    }
    
    func setUserDocument(displayName: String, email: String) {
        self.userRef?.setData([
            "displayName": displayName,
            "email": email
        ]) { error in
            if let err = error {
                print("error during user document setting: \(err)")
            } else {
                print("user document written successfully")
            }
        }
    }
    
    func getUserDocument(handler: @escaping (Dictionary<String, Any>) -> Void) {
        self.userRef?.getDocument(completion: { querySnapshot, error in
            if let err = error {
                print("couldn't fetch user document: \(err)")
            } else if let document = querySnapshot, document.exists {
                handler(document.data()!)
            }
        })
    }
}
