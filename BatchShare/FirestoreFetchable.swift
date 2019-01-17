//
//  FirestoreFetchable.swift
//  BatchShare
//
//  Created by Steve Lederer on 1/15/19.
//  Copyright © 2019 Cameron Milliken. All rights reserved.
//

import Foundation
import Firebase

protocol FirestoreFetchable{
    var uuid: String {get}
    static var CollectionName: String {get}
    init?(with dictionary: [String : Any], id: String)
    var dictionary: [String : Any] {get}
    
    var propertyDescriptions: [String] { get }
}

extension FirestoreFetchable {
    static var collection: CollectionReference {
        return Firestore.firestore().collection(self.CollectionName)
    }
}


