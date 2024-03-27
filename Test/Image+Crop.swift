import SwiftUI

extension Image {
    
    func centerCropped(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: width ?? geo.size.width, height: height ?? geo.size.height)
            .clipped()
        }
    }
    
}

