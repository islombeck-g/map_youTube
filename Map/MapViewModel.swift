import Foundation
import MapKit
import SwiftUI
import SwiftData

final class MapViewModel: ObservableObject {
//    MARK: init MApviewModel
    @Published var cameraPosition: MapCameraPosition = .region(.myRegion)
    
    @Published var pointPosition: CLLocationCoordinate2D? = nil
    @Published var isSettingSheetView: Bool = false
//    MARK: route
    @Published var fromPoint: CLLocationCoordinate2D? = nil
    @Published var toPoint: CLLocationCoordinate2D? = nil
    @Published var isFirtsPoint: Bool = true
    @Published var isRouteMode = false
    @Published var road: MKRoute?
    
    func getRoad(_ style: String) {
        
        let sourcePlacemark = MKPlacemark(coordinate: fromPoint!)
        let destinationPlacemark = MKPlacemark(coordinate: toPoint!)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destinationItem
        
        if style == "automobile" {
            request.transportType = .automobile
        } else {
            request.transportType = .walking
        }
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let road = response?.routes.first else {
                if let error = error {
                    print("error getting direction: \(error.localizedDescription)")
                }
                return
            }
            self.road = road
            self.isSettingSheetView = false   
        }
    }
    
//    MARK: map style
    @Published var mapStyle: Bool = true
    func getMapType() -> MapStyle {
        switch mapStyle {
            case true: return .standard
            case false: return .hybrid
        }
    }
    
//    MARK: map scale
    @Published var scale: Double = 1.0
    @Published var scaleString: String = "1.0"
    
    func updateScale (){
        self.scale = Double(scaleString)!
        self.isSettingSheetView = false
    }
    func resetScale (){
        self.scale = 1.0
        self.isSettingSheetView = false
    }
    
//    MARK: add point mode
    @Published var isAddPointMode:Bool = false
    @Published var selectedCoordinatesToAddLocation: CLLocationCoordinate2D? = nil
    @Published var isNewPointSheetView: Bool = false
    @Published var searcText:String = ""
    
    @Published var showAddNameSheetView:Bool = false
    @Published var nameOfLocation:String = ""
    
}


extension CLLocationCoordinate2D {
    static var myLocation:CLLocationCoordinate2D {
        return .init(latitude: 55.792091, longitude: 49.122082)
    }
}
extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

@Model
class LocalItems: Hashable {
    var name: String
    var coorLa: CLLocationDegrees
    var coorLo: CLLocationDegrees
    init(name: String, coorLa: CLLocationDegrees, coorLo: CLLocationDegrees) {
        self.name = name
        self.coorLa = coorLa
        self.coorLo = coorLo
    }
    
//    MARK: init Hashable protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(coorLa)
        hasher.combine(coorLo)
    }
    static func == (lhs: LocalItems, rhs: LocalItems) -> Bool {
        return lhs.name == rhs.name && lhs.coorLa == rhs.coorLa && lhs.coorLo == rhs.coorLo
    }
}
