import Foundation
import SwiftUI

struct ExampleListModel {
    
    private var _swiftUIExamples: [SwiftUIExample]
    var swiftUIExamples: [SwiftUIExample] { return _swiftUIExamples }

    // MARK: Initialization

    init(swiftUIExamples: [SwiftUIExample]) {
        _swiftUIExamples = swiftUIExamples
    }
    
    static var initial: ExampleListModel {
        return ExampleListModel(swiftUIExamples: [
            SwiftUIExample(
                title: "Nice Button",
                background: UIColor(hex: 0x0a84ff),
                sfSymbol: "cursorarrow",
                view: NiceButtonExample()
            ),
            SwiftUIExample(
                title: "Gallery Access",
                background: UIColor(hex: 0x1B24FF),
                sfSymbol: "lock.rectangle.on.rectangle.fill",
                view: GalleryAccessView()
            ),
            SwiftUIExample(
                title: "Notification Access",
                background: UIColor(hex: 0xFF1B1B),
                sfSymbol: "app.badge",
                view: NotificationSetupView()
            )
        ])
    }
    
}
