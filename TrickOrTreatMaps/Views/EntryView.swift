//
//  EntryPage.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-05.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct EntryView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)

                Text("Welcome to TrickOrTreatMaps!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text("Sign up as a user or let people know you'll be handing out candy!")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                NavigationLink(destination: UserSignUpView()) {
                    Text("User")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                NavigationLink(destination: CandyGiverSignUpView()) {
                    Text("Handing Out Candy")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct MainView: View {
    @State private var isSignedIn = Auth.auth().currentUser != nil
    
    var body: some View {
//        Group {
//            if isSignedIn {
//                ContentView()
//            } else {
//                EntryView()
//            }
//        }
//        .onAppear {
//            Auth.auth().addStateDidChangeListener { _, user in
//                self.isSignedIn = user != nil
//            }
//        }
        EntryView()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
