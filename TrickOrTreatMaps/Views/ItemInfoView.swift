//
//  ItemInfoView.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-04.
//

import SwiftUI
import MapKit

struct ItemInfoView: View {
    var selectedResult: MKMapItem?
    var route: MKRoute?
    @State private var lookAroundScene: MKLookAroundScene?
       
    func getLookAroundScene () {
       lookAroundScene = nil
       Task {
           let request = MKLookAroundSceneRequest(mapItem: selectedResult ?? MKMapItem())
           lookAroundScene = try? await request.scene
       }
    }
    
    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text ("\(selectedResult?.name ?? "")")
                    if let travelTime {
                        Text(travelTime)
                    }
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding (10)
            }
            .onAppear {
                getLookAroundScene()
            }
            .onChange(of: selectedResult) {
                getLookAroundScene()
            }
    }
    
    private var travelTime: String? {
        guard let route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }
}
