import SwiftUI

struct NotificationPushImageView: View {
    var model: NotificationPushModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if let userImage = model.userImage {
                Image(uiImage: userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 38, height: 38)
                    .cornerRadius(38/2)
                    .clipped()
                
                Image(uiImage: model.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 16, height: 16)
                    .cornerRadius(4)
                    .clipped()
                    .offset(x: 3, y: 2.5)
            } else {
                Image(uiImage: model.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 38, height: 38)
                    .cornerRadius(8)
                    .clipped()
            }
        }
    }
}

struct NotificationPushImageView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPushImageView(model: .init())
    }
}
