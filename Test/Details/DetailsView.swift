import Foundation
import SwiftUI

struct DetailsView: View {
    
    var viewModel: HomeViewModel
    var index: Int
    
    var localArticle: LocalArticle { viewModel.localArticles[index] }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                @Bindable var viewModel = viewModel
                
                HStack {
                    TextField("Favorite note", text: $viewModel.localArticles[index].favoriteNote)
                    FavoriteButton(isSet: $viewModel.localArticles[index].favorite)
                }
                HomeCell(viewModel: viewModel, index: index, showFavorite: false)
                Divider()
                if let content = localArticle.content {
                    Text(content)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(16)
        }
    }
    
}
