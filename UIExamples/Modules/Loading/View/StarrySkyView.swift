import SwiftUI

struct StarrySkyView: View {
    @State private var particles: [LoadingParticle] = []
    @State private var bigParticles: [LoadingParticle] = []
    
    private let particleCount = 100
    private let bigParticleCount = 10
    private let colors: Set<Color> = [.yellow, .blue, .pink, .brown, .red, .green, .orange, .cyan, .mint, .indigo]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particles) { particle in
                    Circle()
                        .foregroundColor(particle.color)
                        .opacity(particle.opacity)
                        .frame(width: particle.size, height: particle.size)
                        .scaleEffect(particle.scale)
                        .position(particle.position)
                        .onAppear {
                            Task(priority: .high) {
                                positionParticle(particle, bounds: geometry.size)
                                animateParticle(particle)
                            }
                        }
                }
                
                ForEach(bigParticles) { particle in
                    Circle()
                        .foregroundColor(particle.color)
                        .opacity(particle.opacity)
                        .blur(radius: 30)
                        .frame(width: particle.size, height: particle.size)
                        .position(particle.position)
                        .onAppear {
                            animateBigParticle(particle, bounds: geometry.size)
                        }
                }
            }
            .onAppear {
                bigParticles = generateBigParticles(in: geometry.size)
                particles = generateParticles(in: geometry.size)
            }
        }
    }
    
    private func generateBigParticles(in size: CGSize) -> [LoadingParticle] {
        var particles: [LoadingParticle] = []
        
        for _ in 0..<bigParticleCount {
            let x = CGFloat.random(in: 0...size.width)
            let y = CGFloat.random(in: 0...size.height)
            let size = CGFloat.random(in: 100...300)
            
            particles.append(
                LoadingParticle(
                    color: colors.randomElement()!,
                    position: CGPoint(x: x, y: y),
                    size: size,
                    opacity: 0,
                    scale: 1.0
                )
            )
        }
        
        return particles
    }
    
    private func generateParticles(in size: CGSize) -> [LoadingParticle] {
        var particles: [LoadingParticle] = []
        
        for _ in 0..<particleCount {
            let x = size.width / 2.0
            let y = size .height / 2.0
            let size = CGFloat.random(in: 1...3)
            
            particles.append(
                LoadingParticle(
                    color: .primary,
                    position: CGPoint(x: x, y: y),
                    size: size,
                    opacity: Double.random(in: 0.1...1.0),
                    scale: CGFloat.random(in: 0.5...3)
                )
            )
        }
        
        return particles
    }
    
    private func positionParticle( _ particle: LoadingParticle, bounds: CGSize) {
        guard let index = particles.firstIndex(where: { $0.id == particle.id }) else {
            return
        }
        
        let x = CGFloat.random(in: 0...bounds.width)
        let y = CGFloat.random(in: 0...bounds.height)
        
        withAnimation(Animation.interpolatingSpring(stiffness: 100, damping: 10)) {
            particles[index].position = CGPoint(x: x, y: y)
        }
    }
    
    @MainActor
    private func animateBigParticle(_ particle: LoadingParticle, bounds: CGSize) {
        guard let index = bigParticles.firstIndex(where: { $0.id == particle.id }) else {
            return
        }
        
        withAnimation(createAnimation()) {
            let particleSize = bigParticles[index].size
            bigParticles[index].position.x += CGFloat.random(in: -50...50)
            
            let leftBound = max(0, bigParticles[index].position.x)
            let widthBound = min(leftBound, bounds.width - particleSize / 2)
            bigParticles[index].position.x = widthBound
            bigParticles[index].position.y += CGFloat.random(in: -50...50)
            
            let topBound = max(0, bigParticles[index].position.y)
            let heightBound = min(topBound, bounds.height - particleSize / 2)
            bigParticles[index].position.y = heightBound
            
            bigParticles[index].opacity = 0.1
        }
        
        Task {
            try? await Task.sleep(for: .seconds(0.2))
            animateBigParticle(bigParticles[index], bounds: bounds)
        }
    }
    
    @MainActor
    private func animateParticle(_ particle: LoadingParticle) {
        guard let index = particles.firstIndex(where: { $0.id == particle.id }) else {
            return
        }
        
        let opacity = Double.random(in: 0.1...1.0)
        let scale = CGFloat.random(in: 0.5...2)
        let x = CGFloat.random(in: -15...15)
        let y = CGFloat.random(in: -15...15)
        
        withAnimation(createAnimation()) {
            particles[index].opacity = opacity
            particles[index].scale = scale
            particles[index].position.x += x
            particles[index].position.y += y
        }
        
        Task(priority: .low) {
            try? await Task.sleep(until: .now + .seconds(Int.random(in: 1...2)))
            
            animateParticle(particles[index])
        }
    }
    
    private func createAnimation() -> Animation {
        Animation.easeInOut(duration: Double.random(in: 1...2))
    }
}

#Preview {
    StarrySkyView()
}
