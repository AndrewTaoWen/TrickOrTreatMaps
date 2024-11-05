//
//  ContentView.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-04.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let parking = CLLocationCoordinate2D(latitude: 43.648, longitude: -79.40)
}

extension MKCoordinateRegion {
    static let toronto = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 43.648,
            longitude: -79.40),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1)
    )
    
    static let waterloo = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 43.472,
            longitude: -80.524),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1)
    )
}

extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: self.pointCount)
        self.getCoordinates(&coords, range: NSRange(location: 0, length: self.pointCount))
        return coords
    }
}

struct ParkingAnnotationView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray)
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.secondary, lineWidth: 5)
            Image(systemName: "car")
                .padding(5)
        }
    }
}

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    
    
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @State private var walkingCoordinates: [CLLocationCoordinate2D] = []
    @State private var drivingCoordinates: [CLLocationCoordinate2D] = []
        
    var body: some View {
        mapView
            .safeAreaInset(edge: .bottom) {
                bottomOverlay
            }
            .onChange(of: searchResults) {
                position = .automatic
            }
            .onChange(of: selectedResult) {
                getDirections()
            }
            .onMapCameraChange { context in
                visibleRegion = context.region
            }
        
    }

    private var mapView: some View {
        Map(position: $position, selection: $selectedResult) {
            ParkingAnnotation()
            SearchResultsAnnotations(searchResults: searchResults, route: route, drivingCoordinates: drivingCoordinates, walkingCoordinates: walkingCoordinates)
        }
        .mapStyle(.standard(elevation: .realistic))
    }

    private var bottomOverlay: some View {
        HStack {
            Spacer()
            VStack(spacing: 0) {
                if let selectedResult {
                    ItemInfoView(selectedResult: selectedResult, route: route)
                        .frame(height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding([.top, .horizontal])
                }

                BeantownButtons(position: $position,
                                searchResults: $searchResults,
                                visibleRegion: visibleRegion)
                    .padding(.top)
            }
            Spacer()
        }
        .background(.thinMaterial)
    }

    private struct ParkingAnnotation: MapContent {
        
        var body: some MapContent {
            Annotation("Parking", coordinate: .parking) {
                ParkingAnnotationView()
            }
            .annotationTitles(.hidden)
        }
    }

    private struct SearchResultsAnnotations: MapContent {
        let searchResults: [MKMapItem]
        let route: MKRoute?
        let drivingCoordinates: [CLLocationCoordinate2D]
        let walkingCoordinates: [CLLocationCoordinate2D]
        
        var body: some MapContent {
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
            .annotationTitles(.hidden)
            
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
            
            if !drivingCoordinates.isEmpty {
                MapPolyline(coordinates: drivingCoordinates)
                    .stroke(.blue, lineWidth: 5)
            }
            
            if !walkingCoordinates.isEmpty {
                let gradient = LinearGradient(colors: [.red, .blue, .green], startPoint: .leading, endPoint: .trailing)
                let stroke = StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [10, 5])
                
                MapPolyline(coordinates: walkingCoordinates)
                    .stroke(gradient, style: stroke)
            }
        }
    }

    func getDirections() {
        route = nil
        walkingCoordinates = []
        drivingCoordinates = []
        guard let selectedResult else { return }
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: .parking))
        let destination = selectedResult
        
        
        func calculateRoute(transportType: MKDirectionsTransportType, completion: @escaping ([CLLocationCoordinate2D]?) -> Void) {
            let request = MKDirections.Request()
            request.source = source
            request.destination = destination
            request.transportType = transportType
    
            Task {
                let directions = MKDirections(request: request)
                let response = try? await directions.calculate()
                if let route = response?.routes.first {
                    completion(route.polyline.coordinates)
                } else {
                    completion(nil)
                }
            }
            
        }
        
        calculateRoute(transportType: .automobile) { coordinates in
            drivingCoordinates = coordinates ?? []
        }
           
        calculateRoute(transportType: .walking) { coordinates in
            walkingCoordinates = coordinates ?? []
        }
    
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
