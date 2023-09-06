import Foundation

struct NotificationSetupModel {
    private var _notifications: [NotificationFeature]
    var notifications: [NotificationFeature] { return _notifications }
    
    init(notifications: [NotificationFeature]) {
        _notifications = notifications
    }
    
    subscript(dreamAt index: Int) -> NotificationFeature {
        get {
            return _notifications[index]
        }
        
        set {
            _notifications[index] = newValue
        }
    }
    
    static var initial: NotificationSetupModel {
        return NotificationSetupModel(notifications: [
            NotificationFeature(
                systemNamed: "shippingbox",
                title: "Order Status",
                subtitle: "Receive status alerts about your latest order activity."
            ),
            NotificationFeature(
                systemNamed: "calendar",
                title: "Session Reminders",
                subtitle: "Get reminders about your upcoming Today at Apple sessions."
            ),
            NotificationFeature(
                systemNamed: "bell.badge",
                title: "Announcements and Offers",
                subtitle: "Get information on new products, special store events, personalized recommendations and more."
            )
        ])
    }
}

struct NotificationFeature: Hashable {
    var systemNamed: String
    var title: String
    var subtitle: String
}
