//
//  Auth.swift
//  Diplom
//
//  Created by Махова Татьяна on 01.02.2023.
//

import Foundation
import FirebaseAuth

class AuthManager {
    private let auth = Auth.auth()
    func createUser(user: UserModel, completionBlock: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.createUser(withEmail: user.email, password: user.password) { (result, error) in
            guard let result else{
                completionBlock(.failure(error!))
                return
            }
            completionBlock(.success(result))
        }
    }
    
    func checkAuthorization(completion: @escaping(Bool) -> Void) {
        if Auth.auth().currentUser != nil {
            completion(true)
        } else {
            completion(false)
        }
        

    }
    
    
    
    
    
    
}

