import Foundation
import SwiftUI

struct DetailsView: View {
    
    var viewModel: HomeViewModel
    var index: Int
    
    var body: some View {
        VStack(spacing: 8) {
            @Bindable var viewModel = viewModel
            // TODO: bind favoriteNote and favorite
            HomeCell(viewModel: viewModel, index: index)
        }
    }
    
}
