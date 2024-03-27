import Foundation
import SwiftUI

struct HeaderCell: View {
    
    let data: HeaderCellData
    
    private var image: some View {
//        GeometryReader { proxy in
//            let _ = print("proxy: ", proxy.size)
            AsyncImage(url: data.imageURL) { image in
                ZStack(alignment: .bottomLeading) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                    if let overlap = data.imageOverlayMessage {
                        Text(overlap)
                            .fixedSize()
                            .font(.system(size: 12, weight: .bold))
                            .padding(4)
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                            .padding(8)
                    }
                }
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.top, 8)
//        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            image
            Text(data.title)
                .fixedSize(horizontal: false, vertical: true)
                .font(.headline)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.trailing, .leading], 12)
        }
        .padding(8)
    }
}

struct TextCell: View {
    
    let data: TextCellData
    
    var body: some View {
        Text(data.text)
            .fixedSize(horizontal: false, vertical: true)
            .font(.subheadline)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.trailing, .leading], 12)
    }
}

struct HomeCard: View {
    
    @State var newData: NewData
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(newData.cellTypeList) { cellType in
                HomeCellFactory.create(from: cellType)
                Divider()
            }
        }
    }
}

struct HomeCellFactory {
    
    @ViewBuilder
    static func create(from data: CellType) -> some View {
        switch data {
        case let .header(data):
            HeaderCell(data: data)
        case let .text(data):
            TextCell(data: data)
        }
    }
    
}
