import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            StarrySkyView()
            
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .tint(.primary)
                    .padding(.bottom, -2)
                
                Text(LocalizedStringKey("Loading View"))
                    .font(.system(size: 34, weight: .bold))
                    .padding(.horizontal, 40)
                    .padding(.bottom, -10)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoadingView()
}
