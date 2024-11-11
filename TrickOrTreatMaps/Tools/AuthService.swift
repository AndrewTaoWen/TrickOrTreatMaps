//
//  AuthService.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-06.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    static let shared = AuthService()
    
    private init() { }
    
    private func printError(error: NSError?) {
        if let error = error {
            print("Error during Firebase Auth user creation:")
            print("Error code: \(error.code)")
            print("Error description: \(error.localizedDescription)")
            print("Error userInfo: \(error.userInfo)")
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signUp(name: String, email: String, password: String, userType: String, candyTypes: [String], address: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error as NSError? {
                self.printError(error: error)
                completion(.failure(error))
            } else if let user = result?.user {
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData([
                    "email": email,
                    "userType": userType,
                    "candyTypes": candyTypes,
                    "fullName": name,
                    "address": address
                ]) { error in
                    if let error = error as NSError? {
                        self.printError(error: error)
                        completion(.failure(error))
                    } else {
                        print("User data set successfully in Firestore.")
                        self.signIn(email: email, password: password, completion: completion)
                        completion(.success(()))
                    }
                }
            }
        }
    }
}
