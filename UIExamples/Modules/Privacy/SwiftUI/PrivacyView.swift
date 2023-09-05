import SwiftUI

struct PrivacyTestView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                PrivacyView()
            } label: {
                Text("Privacy")
            }
            .navigationTitle("Show Privacy")
        }
    }
}

struct PrivacyView: View {
    var body: some View {
        ScrollView {
            Image(systemName: "lock.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 36)
                .foregroundColor(.blue)
                .padding(.top, 20)
            
            Text("Privacy")
                .font(.system(size: 25, weight: .bold))
                .padding(.top, 40)
            
            Text("Text")
                .font(.system(size: 25, weight: .bold))
                .padding(.top, 40)

        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyTestView()
    }
}
