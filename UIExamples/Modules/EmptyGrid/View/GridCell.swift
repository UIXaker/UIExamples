import SwiftUI

struct GridCell: View {
    let isGlowing: Bool
    let cellSize: CGFloat
    let glowingColorOpacityRange: ClosedRange<Double>
    let colors: Set<Color>
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .stroke(Color.primary.opacity(0.13), lineWidth: 1)
            .frame(width: cellSize, height: cellSize)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(isGlowing ? colors.randomElement()!.opacity(randomGlowingColorOpacity()) : Color.clear)
                    .opacity(isGlowing ? 0 : 1)
                    .animation(Animation.linear(duration: 2).delay(isGlowing ? 0.3 : 0), value: isGlowing)
            )
    }
    
    func randomGlowingColorOpacity() -> Double {
        Double.random(in: glowingColorOpacityRange)
    }
}
