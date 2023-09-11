import SwiftUI

struct NotificationPushView: View {
    @State private var pushHeight: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    @Binding var notStack: Bool
    
    let model: NotificationPushModel
    var index: Int
    
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
                .background(
                    GeometryReader {
                        Color.clear.preference(key: ContentPreferenceKey.self, value: $0.size.height)
                    }
                )
                .onPreferenceChange(ContentPreferenceKey.self) {
                    contentHeight = $0
                }
                .offset(y: (pushHeight - contentHeight)/2 - 14)
                .opacity(getContentOpacity())
                
                
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
                .opacity(getContentOpacity())
            }
            .padding(EdgeInsets(top: 14.0, leading: 14.0, bottom: 12.0, trailing: 18.0))
            .background(
                GeometryReader {
                    Color.clear.preference(
                        key: PushHeightPreferenceKey.self,
                        value: $0.size.height
                    )
                }
            )
            .onPreferenceChange(PushHeightPreferenceKey.self) {
                pushHeight = $0
            }
            .background(.thinMaterial)
            .background(
                getPushBackground(),
                in: RoundedRectangle(cornerRadius: 24.0, style: .continuous)
            )
            .animation(.linear(duration: 0.2), value: notStack)
    }
    
    private func getPushBackground() -> some ShapeStyle {
        if !notStack {
            if index == 0 {
                return .quaternary
            }

            if index == 1 {
                return .tertiary
            }

            return .secondary
        }

        return .quaternary
    }
    
//    private func getPushBackground() -> Color {
//        if !notStack {
//            if index == 0 {
//                return .brown
//            }
//
//            if index == 1 {
//                return  .pink
//            }
//
//            if index == 2 {
//                return .mint
//            }
//
//            return .blue
//        }
//
//        return .white
//    }
    
    private func getContentOpacity() -> Double {
        if !notStack && index > 2 {
            return 0.0
        }
        
        return 1.0
    }
}

extension NotificationPushView {
    struct PushHeightPreferenceKey: PreferenceKey {
        /// The default value of the preference.
        ///
        /// Views that have no explicit value for the key produce this default
        /// value. Combining child views may remove an implicit value produced by
        /// using the default. This means that `reduce(value: &x, nextValue:
        /// {defaultValue})` shouldn't change the meaning of `x`.
        static var defaultValue: CGFloat = 0
        
        /// Combines a sequence of values by modifying the previously-accumulated
        /// value with the result of a closure that provides the next value.
        ///
        /// This method receives its values in view-tree order. Conceptually, this
        /// combines the preference value from one tree with that of its next
        /// sibling.
        ///
        /// - Parameters:
        ///   - value: The value accumulated through previous calls to this method.
        ///     The implementation should modify this value.
        ///   - nextValue: A closure that returns the next value in the sequence.
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
    
    struct ContentPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
}

struct NotificationPushView_Previews: PreviewProvider {
    static var previews: some View {
//        NotificationPushView(
//            inStack: false,
//            model: .init(
//                icon: .init(named: "notification-push-app-icon"),
//                userImage: .init(named: "notification-push-janum"),
//                contentImage: .init(named: "notification-content-image-3"),
//                title: "Janum Trivedi",
//                subtitle: "Can we talk\nabout the game\nlast night?",
//                time: "2h ago"
//            ),
//            index: 0
//        )
//        .padding(.horizontal, 24)
        
        NotificationSetupView3()
    }
}
