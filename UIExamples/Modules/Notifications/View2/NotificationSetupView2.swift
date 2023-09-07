import SwiftUI

struct NotificationSetupView2: View {
    @Environment(\.dismiss) private var dismiss
    @State private var animate = false
    
    let blurHeight = 160.0
    let buttonHeight = 24.0
    let blurTint: UIColor = .secondarySystemBackground.withAlphaComponent(0)
    let center = UNUserNotificationCenter.current()
    let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    let model = NotificationSetupModel.initial
    let notificationModel = NotificationPushModel(icon: nil, title: "TitleTitleTitleTitleTitleTitle", subtitle: "Descriptidkdkfjlaksdjfllaksdjfdddon", time: "Yesterday 17:00")
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(spacing: 16) {
                            NotificationPushView(model: .init(icon: .init(named: "notification-push-icon"), userImage: .init(named: "notification-push-user"), contentImage: nil, title: "Title", subtitle: "Desc", time: "now"))
                            
                            NotificationPushView(model: .init(icon: .init(named: "notification-push-icon"), userImage: .init(named: "notification-push-user"), contentImage: nil, title: "Title", subtitle: "Desc", time: "now"))
                            
                            NotificationPushView(model: .init(icon: .init(named: "notification-push-icon"), userImage: .init(named: "notification-push-user"), contentImage: nil, title: "Title", subtitle: "Desc", time: "now"))
                            
                            NotificationPushView(model: .init(icon: .init(named: "notification-push-icon"), userImage: .init(named: "notification-push-user"), contentImage: nil, title: "Title", subtitle: "Desc", time: "now"))
                            
                            NotificationPushView(model: .init(icon: .init(named: "notification-push-icon"), userImage: .init(named: "notification-push-user"), contentImage: nil, title: "Title", subtitle: "Desc", time: "now"))
                            
                            Text("Let's set up your notifications.")
                                .font(.system(size: 34, weight: .bold))
                                .multilineTextAlignment(.center)
                                .kerning(-0.22)
                                .padding(.top, 22)
                            
                            Text("Allow us to send you notifications about A, B, and C. You can modify and turn off individual notifications at any time in Settings.")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                                .lineSpacing(2)
                        }
                        .padding(.horizontal, 44)
                        .offset(y: -12)
                        
//                        VStack(alignment: .leading, spacing: 32) {
//                            ForEach(model.notifications, id: \.self) { item in
//                                HStack(spacing: 10) {
//                                    Image(systemName: item.systemNamed)
//                                        .font(.system(size: 36, weight: .semibold))
//                                        .frame(width: 52, height: 52)
//                                        .foregroundColor(.secondary)
//                                        .fontWeight(.semibold)
//                                        .padding(.leading, 24)
//
//                                    VStack(alignment: .leading, spacing: 2) {
//                                        Text(item.title)
//                                            .font(.system(size: 15, weight: .semibold))
//
//                                        Text(item.subtitle)
//                                            .font(.system(size: 15, weight: .regular))
//                                            .foregroundColor(.secondary)
//                                            .multilineTextAlignment(.leading)
//                                    }
//                                    .padding(.trailing, 32)
//                                }
//                            }
//                        }
//                        .offset(y: 18)
                    }
                    .padding(.top, geometry.size.height/12 + geometry.safeAreaInsets.top)
                    .padding(.bottom, geometry.safeAreaInsets.bottom + blurHeight)
                }
                .onAppear {
                    animate.toggle()
                }
                .onTapGesture {
                    animate.toggle()
                }
                
                ZStack(alignment: .bottom) {
                    BlurView(colorTint: blurTint)
                        .mask({
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .black]),
                                startPoint: UnitPoint(x: 0, y: 0.1),
                                endPoint: UnitPoint(x: 0, y: 0.4)
                            )
                        })
                        .frame(height: blurHeight + geometry.safeAreaInsets.bottom)
                    
                    VStack(spacing: 4) {
                        Button(action: {
                            impactFeedback.impactOccurred()
                            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                                if let error = error {
                                    // Handle the error here.
                                }
                                
                                dismiss()
                            }
                        }) {
                            Text("Turn on Notifications")
                                .foregroundColor(.white)
                                .frame(height: buttonHeight)
                        }
                        .buttonStyle(NiceButton(color: .blue))
                        .padding(.horizontal, 44)
                        
                        Button {
                            dismiss()
                        } label: {
                            Text("Not Now")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                        }
                        .frame(height: 50)
                        .padding(.bottom, 6)
                    }
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

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
                        .font(.system(size: 15))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 2)
                        .lineLimit(4)
                }
                
                Spacer()
            }
            
            VStack(alignment: .trailing, spacing: 6) {
                Text(model.time)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 13))
                    .padding(.top, 2)
                
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

struct NotificationPushStackView: View {
    let model: NotificationPushModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NotificationPushView(model: .init())
                .padding(.horizontal, 25)
            
            NotificationPushView(model: .init())
                .padding(.bottom, 8)
                .padding(.horizontal, 15)
            
            NotificationPushView(model: model)
                .padding(.bottom, 16)
        }
    }
}

struct NotificationSetupView2_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSetupView2()
    }
}
