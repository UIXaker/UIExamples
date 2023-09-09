import Foundation

struct NotificationFeature: Identifiable, Hashable {
    var id: String {
        return systemNamed + title
    }
    
    let systemNamed: String
    let title: String
    let subtitle: String
}
