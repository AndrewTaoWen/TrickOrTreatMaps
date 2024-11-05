//
//  BeantownButtons.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-04.
//

import SwiftUI
import MapKit

struct BeantownButtons: View {
    
    @Binding var position: MapCameraPosition
    
    @Binding var searchResults: [MKMapItem]
    
    var visibleRegion: MKCoordinateRegion?
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 43.648, longitude: -79.40),
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
        )
        
        Task {
            let search = MKLocalSearch(request: request)
            if let response = try? await search.start() {
                searchResults = response.mapItems
            } else {
                searchResults = []
            }
        }
    }

    var body: some View {
        HStack {
            Button {
                search(for: "playground")
            } label: {
                Label("Playground", systemImage: "figure.and.child.holdinghands")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                search(for: "beach")
            } label: {
                Label("Beaches", systemImage: "beach.umbrella")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                position = .region(.toronto)
            } label: {
                Label("Toronto", systemImage: "building.2")
            }
            .buttonStyle(.bordered)
            
            Button {
                position = .region(.waterloo)
            } label: {
                Label("Waterloo", systemImage: "water.waves")
            }
            .buttonStyle(.bordered)
        }
        .labelStyle(.iconOnly)
    }
}
