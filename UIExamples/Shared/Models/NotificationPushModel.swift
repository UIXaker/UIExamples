import UIKit

struct NotificationPushModel {
    init(icon: UIImage? = nil, userImage: UIImage? = nil, contentImage: UIImage? = nil, title: String = "Title", subtitle: String = "Description", time: String = "now") {
        self.icon = icon ?? UIImage(named: "notification-push-unknown")!
        self.userImage = userImage
        self.contentImage = contentImage
        self.title = title
        self.subtitle = subtitle
        self.time = time
    }
    
    let icon: UIImage
    let userImage: UIImage?
    let contentImage: UIImage?
    let title: String
    let subtitle: String
    let time: String
}
