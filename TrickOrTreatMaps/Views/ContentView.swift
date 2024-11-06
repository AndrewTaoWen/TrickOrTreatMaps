import SwiftUI
import MapKit

struct IdentifiableLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.648, longitude: -79.40),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var userPath: [IdentifiableLocation] = []
    
    @StateObject private var locationManager = LocationManager()
    
    private var bottomOverlay: some View {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    Text("Tracing user location...")
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding([.top, .horizontal])
                }
                Spacer()
            }
    }
    
    var body: some View {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: userPath) { location in
                MapMarker(coordinate: location.coordinate, tint: .blue)
            }
            .safeAreaInset(edge: .bottom) {
               bottomOverlay
            }
            .onAppear {
               locationManager.requestLocation()
            }
            .onChange(of: locationManager.userLocation) { newLocation in
               if let newLocation = newLocation {
                   print("New Location: \(newLocation.latitude), \(newLocation.longitude)")
                   region.center = newLocation
                   userPath = [IdentifiableLocation(coordinate: newLocation)]
               }
            }
        }}

struct UserLocationMarker: MapContent {
    let coordinate: CLLocationCoordinate2D
    
    var body: some MapContent {
        Annotation("User Location", coordinate: coordinate) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.7))
                    .frame(width: 12, height: 12)
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 16, height: 16)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
