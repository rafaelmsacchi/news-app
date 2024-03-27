import SwiftUI
import Combine

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        List(viewModel.newsList) { new in
            HomeCard(newData: new)
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 5)
                        .background(.clear)
                        .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                        .padding(
                            EdgeInsets(
                                top: 8,
                                leading: 8,
                                bottom: 8,
                                trailing: 8
                            )
                        )
                )
        }
        .listStyle(.plain)
    }
}

#Preview {
    HomeView()
}
