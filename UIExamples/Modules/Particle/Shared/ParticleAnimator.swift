import SwiftUI

class ParticleAnimator: ObservableObject {
    typealias ParticleType = ButtonParticle.ParticleType
    
    @Published var particles: [ButtonParticle] = []
    @Published var rect: CGRect = .zero {
        didSet {
            particles.append(
                contentsOf: generateParticles(count: 40, around: rect, type: .down)
            )
            particles.append(
                contentsOf: generateParticles(count: 12, around: rect, type: .up)
            )
        }
    }
    @Published var isPressed: Bool = false
    
    private var isAnimating: Bool = false
    private var converter = ProgressConverter(minValue: 0, maxValue: 360)

    @MainActor
    func animate() {
        Task {
            isAnimating.toggle()
            
            while isAnimating {
                try await Task.sleep(for: .seconds(1.0/60.0))
                updateParticles()
            }
        }
    }
    
    private func updateParticles() {
        for index in 0..<particles.count {
            updateParticle(at: index)
        }
    }
    
    private func updateParticle(at index: Int) {
        if particles[index].dalay > 0 {
            particles[index].dalay -= isPressed ? particles[index].dalay : 0.016
        } else {
            updateOpacityParticle(at: index)
            moveParticle(at: index)
        }
    }
        
    func updateOpacityParticle(at index: Int) {
        switch particles[index].opacityType {
        case .appearing:
            particles[index].opacity = min(1, particles[index].opacity + 0.016)
        case .disappearing:
            particles[index].opacity -= 0.016
        }
                
        let maxDegree: Double = particles[index].type == .down ? 45 : 90
        
        if particles[index].realAngle.degrees > maxDegree {
            particles[index].opacityType = .disappearing
        }
        
        if particles[index].opacity <= 0 {
            particles[index].opacityType = .appearing
            resetParticlePosition(at: index)
        }
    }

    private func resetParticlePosition(at index: Int) {
        particles[index].easingAngle = .zero
        particles[index].realAngle = .zero
        particles[index].dalay = CGFloat.random(in: 0.1...6)
        particles[index].radius = particles[index].type == .down ? .random(in: -rect.width/2...rect.width/2) : .random(in: -rect.height/3...rect.height/3)
    }

    private func moveParticle(at index: Int) {
        let speedMulti: CGFloat = particles[index].type == .down ? 2 : 3
        let speed = isPressed ? particles[index].speed * speedMulti : particles[index].speed
        let newAngle = particles[index].realAngle + Angle.degrees(0.016 * speed)
        let easingAngle: Angle = .degrees(converter.convertWithEaseOut(newAngle.degrees))
        
        particles[index].realAngle = newAngle
        particles[index].easingAngle = easingAngle
        particles[index].rotation = particles[index].rotationType == .onAxis ? easingAngle : -easingAngle
        
        if particles[index].radius > 0 {
            particles[index].radius += (0.016 * speed)/3
        } else {
            particles[index].radius -= (0.016 * speed)/3
        }
        
        particles[index].x = particles[index].radius * cos(particles[index].easingAngle.radians)
        particles[index].y = particles[index].radius/2.4 * sin(particles[index].easingAngle.radians)
    }

    private func generateParticles(count: Int, around rect: CGRect, type: ParticleType) -> [ButtonParticle] {
        var particles: [ButtonParticle] = []
        typealias ShapeType = ButtonParticle.ShapeType
        typealias RotationType = ButtonParticle.RotationType
        
        for _ in 0..<count {
            let speed: CGFloat = type == .down ? .random(in: 8...18) : .random(in: 14...20)
            let radius: CGFloat = type == .down ? .random(in: -rect.width/1.5...rect.width/1.5) : .random(in: -rect.height/2...rect.height/2)
            let x = CGFloat.random(in: -rect.width/4...rect.width/4)
            let y = CGFloat(0)
            let startDalay = CGFloat.random(in: 0.1...6)
            let color = type == .down ? Color(
                .sRGB,
                red: Double.random(in: 0...1),
                green: Double.random(in: 0...1),
                blue: Double.random(in: 0...1)
            ) : .white
            let side = CGFloat.random(in: 6...12)
            let shape = [ShapeType.circle, ShapeType.star].randomElement()!
            let rotation = [RotationType.onAxis, RotationType.offAxis].randomElement()!
            
            let particle = ButtonParticle(
                type: type,
                shape: shape,
                rotationType: rotation,
                rotation: .zero,
                opacityType: .appearing,
                dalay: startDalay,
                x: x,
                y: y,
                speed: speed,
                easingAngle: .zero,
                realAngle: .zero,
                radius: radius,
                color: color,
                opacity: 0,
                width: side,
                height: side
            )
            
            particles.append(particle)
        }
        
        return particles
    }
    
    private func random(in range: ClosedRange<CGFloat>, excludeRange: ClosedRange<CGFloat>) -> CGFloat {
        while true {
            let randomValue = CGFloat.random(in: range)
            if excludeRange.contains(randomValue)  {
                continue
            }
            
            return randomValue
        }
    }
}
