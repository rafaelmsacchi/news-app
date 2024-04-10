import Foundation
import SwiftUI

struct HomeCell: View {
    
    var viewModel: HomeViewModel
    var index: Int
    
    var localArticle: LocalArticle { viewModel.localArticles[index] }
//    @State var localArticle: LocalArticle
    
    private var image: some View {
        AsyncImage(url: localArticle.imageURL) { image in
            ZStack(alignment: .bottomLeading) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 140)
                if let overlap = localArticle.imageOverlayMessage {
                    Text(overlap)
                        .fixedSize()
                        .font(.system(size: 12, weight: .bold))
                        .padding(4)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .padding(8)
                }
            }
            .clipped()
        } placeholder: {
            ProgressView()
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(.top, 8)
    }
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        HStack(spacing: 8) {
            VStack(spacing: 8) {
                image
                Text(localArticle.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.trailing, .leading], 12)
            }
            .clipped()
            Toggle("Favorite", isOn: $viewModel.localArticles[index].favorite)
//            Image(systemName: localArticle.favorite ? "star.fill" : "star")
//                .resizable()
//                .frame(width: 32, height: 32)
//                .onTapGesture {
//                    viewModel.localArticle(from: localArticle.id).favorite.toggle()
//                    viewModel.toggleFavorite(id: localArticle.id)
//                }
        }
        .padding(8)
    }
}
