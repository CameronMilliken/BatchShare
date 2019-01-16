//
//  FirestoreClient.swift
//  BatchShare
//
//  Created by Steve Lederer on 1/15/19.
//  Copyright © 2019 Cameron Milliken. All rights reserved.
//

import Foundation
import Firebase

class FirestoreClient {
    
    static let shared = FirestoreClient()
    
    func fetchFromFirestore<T: FirestoreFetchable>(uuid: String, completion: @escaping (T?) -> Void) {
        let collectionReference = T.collection
        
        collectionReference.document(uuid).getDocument { (documentSnapshot, error) in
            if let error = error {
                print("There was an error in \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists, let objectDictionary = documentSnapshot.data() else { completion(nil) ; return }
            
            let object = T(with: objectDictionary, id: documentSnapshot.documentID)
            completion(object)
        }
    }
    
    func fetchAllInACollectionFromFirestore<T: FirestoreFetchable>(completion: @escaping ([T]?) -> Void) {
        let collectionReference = T.collection
        
        collectionReference.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("There was an error in \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let documents = querySnapshot?.documents else { completion(nil) ; return }
            let dictionaries = documents.compactMap{ $0.data() }
            var returnValue: [T] = []
            for dictionary in dictionaries {
                guard let uuid = dictionary["uuid"] as? String,
                    let object = T(with: dictionary, id: uuid) else { completion(nil) ; return }
                returnValue.append(object)
            }
            completion(returnValue)
        }
    }
    
    func fetchFirestoreWithFieldAndCriteria<T: FirestoreFetchable>(for field: String, criteria: String, completion: @escaping ([T]?) -> Void) {
        let collectionReference = T.collection
        let filteredCollection = collectionReference.whereField(field, isEqualTo: criteria)
        filteredCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("There was an error in\(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let documents = querySnapshot?.documents else { completion(nil) ; return }
            let dictionaries = documents.compactMap{ $0.data() }
            var returnValue: [T] = []
            for dictionary in dictionaries {
                guard let uuid = dictionary["uuid"] as? String,
                    let object = T(with: dictionary, id: uuid) else { completion(nil) ; return }
                returnValue.append(object)
            }
            completion(returnValue)
        }
    }
}
