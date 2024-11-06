//
//  UserSignInForm.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-05.
//

import Foundation
import SwiftUI

struct CandyGiverSignInForm: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowingError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign In")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .textContentType(.password)
            
            Button(action: signIn) {
                Text("Sign In")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
            
            if isShowingError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
        }
        .padding()
    }
    
    // Sign In Function
    func signIn() {
        if email.isEmpty || password.isEmpty {
            isShowingError = true
            errorMessage = "Please fill in all fields."
        } else {
            // Call sign-in service here
            isShowingError = false
            // Proceed with actual sign-in logic
        }
    }
}

struct CandyGiverSignInForm_Previews: PreviewProvider {
    static var previews: some View {
        CandyGiverSignInForm()
    }
}
