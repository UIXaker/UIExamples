import Foundation

struct NotificationSetupModel {
    private(set) var notificationFeatures: [NotificationFeature] = []
    private(set) var notificationPushes: [NotificationPushModel] = []
    
    init(features: [NotificationFeature], pushes: [NotificationPushModel]) {
        notificationFeatures = features
        notificationPushes = pushes
    }
    
    static var initial: NotificationSetupModel {
        let features: [NotificationFeature] = [
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
            ),
        ]
        
        let pushes: [NotificationPushModel] = [
            .init(icon: .init(named: "notification-push-app-icon"), userImage: .init(named: "notification-push-user"), contentImage: nil, title: "Seller", subtitle: "Sure, we can make it for you!", time: "now"),
            .init(icon: .init(named: "notification-push-app-icon"), userImage: nil, contentImage: .init(named: "notification-content-image"), title: "Delivered", subtitle: "Package with 4 items is under your door", time: "2h ago"),
            .init(icon: .init(named: "notification-push-app-icon"), userImage: nil, contentImage: nil, title: "Out for delivery", subtitle: "Your order will be delivered today", time: "3h ago"),
            .init(icon: .init(named: "notification-push-app-icon"), userImage: nil, contentImage: .init(named: "notification-content-image-2"), title: "Back in stock", subtitle: "Item from your wishlist is now available to buy", time: "Yesterday"),
            .init(icon: .init(named: "notification-push-app-icon"), userImage: nil, contentImage: nil, title: "Response from seller", subtitle: "Seller replied to your review", time: "Dec 13"),
            
            
//            .init(icon: .init(named: "notification-push-app-icon"), userImage: .init(named: "notification-push-user"), contentImage: nil, title: "Seller", subtitle: "Sure, we can make it for you!", time: "now"),
//            .init(icon: .init(named: "notification-push-app-icon"), userImage: nil, contentImage: .init(named: "notification-content-image"), title: "Delivered", subtitle: "Package with 4 items is under your door", time: "2h ago"),
//            .init(icon: .init(named: "notification-push-app-icon"), userImage: nil, contentImage: nil, title: "Out for delivery", subtitle: "Your order will be delivered today", time: "3h ago"),
//            .init(icon: .init(named: "notification-push-app-icon"), userImage: nil, contentImage: .init(named: "notification-content-image-2"), title: "Back in stock", subtitle: "Item from your wishlist is now available to buy", time: "Yesterday"),
//            .init(icon: .init(named: "notification-push-app-icon"), userImage: nil, contentImage: nil, title: "Response from seller", subtitle: "Seller replied to your review", time: "Dec 13")
        ]
        
        return NotificationSetupModel(features: features, pushes: pushes)
    }
}
