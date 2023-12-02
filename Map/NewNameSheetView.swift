import SwiftUI
import SwiftData

struct NewNameSheetView: View {
    
    @EnvironmentObject var viewModel: MapViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            TextField("NEW location name", text: self.$viewModel.nameOfLocation)
                .textFieldStyle(.roundedBorder)
                .padding()
            HStack {
                Button {
                    
                    if let pl = self.viewModel.selectedCoordinatesToAddLocation {
                        do {
                            let n = LocalItems(name: self.viewModel.nameOfLocation, coorLa: pl.latitude, coorLo: pl.longitude)
                            self.modelContext.insert(n)
                        }
                        self.viewModel.nameOfLocation = ""
                        self.viewModel.showAddNameSheetView = false
                    }
                    
                } label: {
                    Text("Save")
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    NewNameSheetView()
        .environmentObject(MapViewModel())
}
