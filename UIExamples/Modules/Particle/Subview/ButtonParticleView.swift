import SwiftUI

struct ButtonParticleView: View {
    var particle: ButtonParticle
    
    var body: some View {
        switch particle.shape {
        case .circle:
            Circle()
                .frame(width: particle.width/2, height: particle.height/2)
                .foregroundColor(particle.color)
                .offset(x: particle.x, y: particle.y)
                .opacity(particle.opacity)
        case .star:
            CustomShape()
                .frame(width: particle.width, height: particle.height)
                .foregroundColor(particle.color)
                .rotationEffect(particle.rotation)
                .offset(x: particle.x, y: particle.y)
                .opacity(particle.opacity)
        }
    }
}
