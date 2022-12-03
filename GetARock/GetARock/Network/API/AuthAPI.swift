//
//  AuthAPI.swift
//  GetARock
//
//  Created by 김수진 on 2022/12/03.
//

import Foundation

import FirebaseAuth

struct AuthAPI {
    
    func signIn(withEmail email: String, password: String) async throws -> User {
        let authData = try await Auth.auth().signIn(withEmail: email, password: password)
        UserDefaultHandler.setUserEmail(email: email)
        UserDefaultHandler.setUserPassword(password: password)
        return authData.user
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
}

}
