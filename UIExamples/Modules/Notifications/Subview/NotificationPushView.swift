import SwiftUI

struct NotificationPushView: View {
    let model: NotificationPushModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .center, spacing: 10) {
                NotificationPushImageView(model: model)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(model.title)
                        .font(.system(size: 15, weight: .semibold))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                    Text(model.subtitle)
                        .padding(.all, 0)
                        .font(.system(size: 15))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 2)
                        .lineLimit(4)
                }
                
                if model.contentImage != nil {
                    Spacer(minLength: 40)
                } else {
                    Spacer()
                }
            }
            
            VStack(alignment: .trailing, spacing: 6) {
                Text(model.time)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 13))
                
                if let contentImage = model.contentImage {
                    Image(uiImage: contentImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .mask {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                        }
                }
            }
        }
        .padding(EdgeInsets(top: 14.0, leading: 14.0, bottom: 12.0, trailing: 18.0))
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24.0, style: .continuous))
    }
}

struct NotificationPushView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPushView(model: .init())
    }
}
