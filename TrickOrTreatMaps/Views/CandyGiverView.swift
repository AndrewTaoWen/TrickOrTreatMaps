//
//  CandyGiverSignUp.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-05.
//

import Foundation
import SwiftUI

struct CandyGiverSignUpView: View {
    var body: some View {
        NavigationLink(destination: CandyGiverSignInForm()) {
            Text("Sign in")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 250, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
        }
        
        NavigationLink(destination: CandyGiverSignUpForm()) {
            Text("Sign Up")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 250, height: 50)
                .background(Color.purple)
                .cornerRadius(10)
        }
    }
}
