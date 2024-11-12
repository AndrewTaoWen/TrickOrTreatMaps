//
//  UserSignUpView.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-05.
//

import Foundation
import SwiftUI

struct UserSignUpView: View {
    var body: some View {
        NavigationLink(destination: UserSignInForm()) {
            Text("Sign in")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 250, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
        }
        
        NavigationLink(destination: UserSignUpForm()) {
            Text("Sign Up")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 250, height: 50)
                .background(Color.purple)
                .cornerRadius(10)
        }
    }
}
