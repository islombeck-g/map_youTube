import SwiftUI

struct SidePanelView: View {
    
    @EnvironmentObject var viewModel:MapViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(spacing: 10) {
            
            Group {
                Button {
                    withAnimation {
                        self.viewModel.isAddPointMode.toggle()
                        self.viewModel.isRouteMode = false
                    }
                } label: {
                    Image(systemName: "plus.viewfinder")
                        .font(.system(size: 23))
                        .padding(.all, 10)
                        .foregroundStyle(self.viewModel.isAddPointMode ? .white: .blue)
                        .background(self.viewModel.isAddPointMode ? .orange: .white.opacity(0.7))
                        .clipShape(.rect(cornerRadius: 8))
                }
                
                if self.viewModel.isAddPointMode {
                    
                    Button {
                        withAnimation {
                            self.viewModel.showAddNameSheetView.toggle()
                        }
                      
                    } label: {
                        Image(systemName: "plus.app")
                            .font(.system(size: 23))
                            .padding(.all, 10)
                            .foregroundStyle(.blue)
                            .background(.white.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 8))
                    }
                    
                    Button {
                        do {
                            try modelContext.delete(model: LocalItems.self)
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    } label: {
                        Image(systemName: "trash.circle")
                            .font(.system(size: 23))
                            .padding(.all, 10)
                            .foregroundStyle(.blue)
                            .background(.white.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 8))
                    }
                }
            }
            
            Button {
                self.viewModel.mapStyle.toggle()
            } label: {
                Image(systemName: self.viewModel.mapStyle ? "map": "map.fill")
                    .font(.system(size: 23))
                    .padding(.all, 10)
            }
            .background(.white.opacity(0.7))
            .clipShape(.rect(cornerRadius: 8))
           
                Button {
                    self.viewModel.isRouteMode.toggle()
                    self.viewModel.isAddPointMode = false
                } label: {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 23))
                        .padding(.all, 10)
                        .foregroundStyle(self.viewModel.isRouteMode ? .white: .blue)
                        .background(self.viewModel.isRouteMode ? .orange: .white.opacity(0.7))
                        .clipShape(.rect(cornerRadius: 8))
                }

                Button {
                    self.viewModel.isSettingSheetView.toggle()
                }label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.system(size: 23))
                        .padding(.all, 10)
                }
                .background(.white.opacity(0.7))
                .clipShape(.rect(cornerRadius: 8))
        }
    }
}

#Preview {
    SidePanelView()
        .environmentObject(MapViewModel())
}
