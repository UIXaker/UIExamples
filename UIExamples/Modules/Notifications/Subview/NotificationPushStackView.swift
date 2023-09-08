import SwiftUI

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

struct NotificationPushStackView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPushStackView(model: .init())
    }
}
