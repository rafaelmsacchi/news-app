import SwiftUI

struct FavoriteButton: View {
    
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Image(systemName: isSet ? "star.fill" : "star")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(.yellow)
        }
    }
    
}

#Preview {
    FavoriteButton(isSet: .constant(true))
}
