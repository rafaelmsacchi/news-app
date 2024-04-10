import SwiftUI
import Combine

struct HomeView: View {
    
    var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            topMenu()
            List(viewModel.localArticles.indices, id: \.self) { index in
                let localArticle = viewModel.localArticles[index]
                NavigationLink(value: index) {
                    HomeCell(viewModel: viewModel, index: index)
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
                .navigationDestination(for: Int.self) { index in
                    DetailsView(viewModel: viewModel, index: index)
                }
            }
            .listStyle(.plain)
        }
    }
    
    @ViewBuilder
    private func topMenu() -> some View {
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<viewModel.countries.countries.count, id: \.self) { index in
                        menuItem(at: index, value: value)
                    }
                }
            }
        }
        .padding(.top, 8)
    }
    
    @ViewBuilder
    private func menuItem(at index: Int, value: ScrollViewProxy) -> some View {
        Button {
            viewModel.selectCountry(at: index)
        } label: {
            Text(viewModel.country(at: index).name)
                .foregroundStyle(.primary)
                .font(.caption)
                .frame(width: 100, height: 44)
                .onTapGesture {
                    viewModel.selectCountry(at: index)
                    withAnimation(.easeOut) {
                        value.scrollTo(index)
                    }
                }
        }
        .frame(height: 44)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .buttonStyle(.borderedProminent)
        .tint(viewModel.menuColor(at: index))
    }
    
}
