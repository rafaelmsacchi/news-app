import SwiftUI

struct FavoriteButton: View {
    
    @Binding var isSet: Bool
    
    var body: some View {
        Image(systemName: isSet ? "star.fill" : "star")
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundStyle(.yellow)
            .onTapGesture {
                isSet.toggle()
            }
    }
    
}

#Preview {
    FavoriteButton(isSet: .constant(true))
}
