//
//  APIManager.swift
//  Diplom
//
//  Created by Махова Татьяна on 21.03.2023.
//

import UIKit
import FirebaseFirestore

class APIManager  {
    static let shared = APIManager()
    private func configureFirebase() -> Firestore {
        var dataBase: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        dataBase = Firestore.firestore()
        return dataBase
    }
    func getPlacec(completion: @escaping ([ Place ]) -> Void ) {
        let dataBase = configureFirebase()
        dataBase.collection("Map").getDocuments { result, error in
            guard let result else { return }
            if let error = error{
                print(error.localizedDescription)
            }
          var placeArray: [ Place ] = []
            for doc in result.documents{
                let data = doc.data()
                guard let name = data["name"] as? String else { return }
                guard let geoPoint = data["location"] as? GeoPoint else { return }
                guard let id = data["id"] as? String else { return }
                let imagesURLS = data["imageURL"] as? [ String ]
                let adres = data["adres"] as? String
                
                let location = Location(latitude: geoPoint.latitude, langitude: geoPoint.longitude)
                let place = Place(name: name, location: location, id: id, imageURLString: imagesURLS, adres: adres)
                placeArray.append(place)
            }
            completion(placeArray)
        }
        
    }
    
}
