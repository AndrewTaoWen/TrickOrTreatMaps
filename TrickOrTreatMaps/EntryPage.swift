//
//  EntryPage.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-05.
//

import Foundation
import SwiftUI

struct EntryView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)

                Text("Welcome to TrickOrTreatMaps")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text("Start your Halloween journey and explore the best routes for trick-or-treating!")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                NavigationLink(destination: MainView()) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct MainView: View {
    var body: some View {
        ContentView()
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
