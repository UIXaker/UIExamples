import SwiftUI

struct LoadingParticle: Identifiable {
    let id = UUID()
    let color: Color
    var position: CGPoint
    var size: CGFloat
    var opacity: Double
    var scale: CGFloat
}
