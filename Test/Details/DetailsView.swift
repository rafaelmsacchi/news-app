import Foundation
import SwiftUI

struct DetailsView: View {
    
    @Environment(HomeViewModel.self) private var viewModel
    @State var selectedNew: NewData
    
    var body: some View {
        VStack(spacing: 8) {
            // TODO: bind favoriteNote
            ForEach(selectedNew.cellTypeList) { cellType in
                HomeCellFactory.create(from: cellType)
                    .environment(viewModel)
            }
        }
    }
    
}
