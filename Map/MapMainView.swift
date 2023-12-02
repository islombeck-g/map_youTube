import SwiftUI
import MapKit
import SwiftData

struct MapMainView: View {
    
    @StateObject private var viewModel: MapViewModel = MapViewModel()
    @Query var items: [LocalItems]

    var body: some View {
        
        ZStack {
            MapReader { reader in
                Map(position: self.$viewModel.cameraPosition) {
                    
                    ForEach(self.items, id: \.self) { item in
                        Marker(item.name, coordinate: CLLocationCoordinate2D(latitude: item.coorLa, longitude: item.coorLo))
                            .tint(.orange)
                    }
                    
                    if self.viewModel.isRouteMode {
                        
                        if let pl = self.viewModel.fromPoint {
                            Marker("\(pl.latitude),\(pl.longitude) ", coordinate: pl)
                                .tint(.blue)
                        }
                        if let pl = self.viewModel.toPoint {
                            Marker("\(pl.latitude),\(pl.longitude) ", coordinate: pl)
                                .tint(.green)
                        }
                        if let road = self.viewModel.road {
                            MapPolyline(road)
                                .stroke(.red, lineWidth: 4)
                        }
                    }
                    
                    if self.viewModel.isAddPointMode {
                        if let pl = self.viewModel.selectedCoordinatesToAddLocation {
                            Marker("\(pl.latitude),\(pl.longitude) ", coordinate: pl)
                                .tint(.red)
                        }
                    }
                }
                .scaleEffect(CGFloat(self.viewModel.scale), anchor: .center)
                .mapStyle(self.viewModel.getMapType())
                .onTapGesture(perform: { screenCoord in
                    withAnimation {
                        if self.viewModel.isRouteMode {
                            if self.viewModel.isFirtsPoint {
                                self.viewModel.fromPoint = reader.convert(screenCoord, from: .local)
                            } else {
                                self.viewModel.toPoint = reader.convert(screenCoord, from: .local)
                            }
                        } else if self.viewModel.isAddPointMode {
                            
                            self.viewModel.selectedCoordinatesToAddLocation = reader.convert(screenCoord, from: .local)
                        }
                    }
                   
                })
            }
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    SidePanelView()
                        .environmentObject(self.viewModel)
                        .padding(.bottom, 50)
                        .padding(.trailing, 5)
                }
            }
        }
        .sheet(isPresented: self.$viewModel.isSettingSheetView, content: {
            SettingSheetView()
                .environmentObject(self.viewModel)
                .presentationDetents([.medium, .large])
        })
        .sheet(isPresented: self.$viewModel.showAddNameSheetView, content: {
            NewNameSheetView()
                .modelContainer(for: LocalItems.self)
                .environmentObject(self.viewModel)
                .presentationDetents([.height(150)])
               
        })
    }
}

#Preview {
    MapMainView()
        .environmentObject(MapViewModel())
}
