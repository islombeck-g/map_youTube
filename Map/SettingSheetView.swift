import SwiftUI

struct SettingSheetView: View {
    
    @EnvironmentObject var viewModel: MapViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            
//            MARK: scale module
            Group {
                Text("Scale factor: ")
                HStack {
                    Text("\(self.viewModel.scale.formatted())")
                        .padding(.horizontal, 50)
                        .font(.subheadline)
                        .padding(12)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(radius: 10)
                    
                    Image(systemName: "arrow.forward")
                    
                    TextField("", text: self.$viewModel.scaleString)
                        .font(.subheadline)
                        .padding(12)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(radius: 10)
                }
                
                HStack {
                    Button {
                        self.viewModel.resetScale()
                    } label: {
                        Text("Reset")
                            .foregroundStyle(.red)
                    }
                    
                    Spacer()
                    
                    Button {
                        self.viewModel.updateScale()
                    } label: {
                        Text("Apply")
                    }
                }
                .buttonStyle(.bordered)
                .padding(.top, 10)
            }
            
            Divider()
                .padding(.top, 15)
            
//            MARK: road module
            Button {
                withAnimation {
                    self.viewModel.isRouteMode.toggle()
                }
            } label: {
                Text("Road Mode")
            }
            .buttonStyle(.bordered)
            
            
            if self.viewModel.isRouteMode {
                
                Text("Road:")
                
                HStack {
                    Button {
                        self.viewModel.isFirtsPoint = true
                        self.dismiss()
                    } label: {
                        Text("Select From:")
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    if let pl = self.viewModel.fromPoint {
                        Text("\(pl.latitude), \(pl.longitude)")
                            .font(.subheadline)
                            .padding(12)
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 10)
                            
                    }
                    
                }
                
                HStack {
                    Button {
                        self.viewModel.isFirtsPoint = false
                        self.dismiss()
                    } label: {
                        Text("Select To:")
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    if let pl = self.viewModel.toPoint {
                        Text("\(pl.latitude), \(pl.longitude)")
                            .font(.subheadline)
                            .padding(12)
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 10)
                    }
                    
                }
                
                Text("Type of road:")
                HStack {
                    Button {
                        self.viewModel.getRoad("automobile")
                    } label: {
                        Image(systemName: "car")
                    }
                    Button {
                        self.viewModel.getRoad("walk")
                    } label: {
                        Image(systemName: "figure.walk.circle")
                    }
                }
                .disabled(self.viewModel.toPoint == nil || self.viewModel.fromPoint == nil)
                .buttonStyle(.bordered)
              
            }
            
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}

#Preview {
    SettingSheetView()
        .environmentObject(MapViewModel())
}
