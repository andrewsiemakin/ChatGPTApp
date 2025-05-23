//
//  AuthService.swift
//  ChatGPTApp
//
//  Created by Andrew on 14.05.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AuthService {
    
    let db = Firestore.firestore()
    func checkUserExist(email: String) async throws -> Bool {
        let documentSnapshot = db.collection("users").whereField("email", isEqualTo: email).count
        let count = try await documentSnapshot.getAggregation(source: .server).count
        return Int(truncating: count) > 0
        
    }
    
    func login(email: String, password: String, userExist: Bool) async throws -> AuthDataResult? {
       
        guard !password.isEmpty else {
            return nil
        }
        
        if userExist {
            return try await Auth.auth().signIn(withEmail: email, password: password)
        } else {
            return try await Auth.auth().createUser(withEmail: email, password: password)
        }
    }
}
