import SwiftUI

struct EmptyGridView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                GridView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Text("You don't have any projects yet")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal, 40)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct EmptyGridView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyGridView()
    }
}
