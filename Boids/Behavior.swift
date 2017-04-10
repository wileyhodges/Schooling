import UIKit
import GameplayKit

// Algorithm : http://www.kfish.org/boids/pseudocode.html

/**
 Behavior protocol
 - All behaviors must adopt this protocol
 **/
protocol Behavior {
    var velocity: CGPoint { get }
}

/**
 Cohesion
 
 - This behavior applies a tendency to move the boid
 toward the averaged position of the entire flock
 **/
class Cohesion: Behavior {
    var velocity: CGPoint = CGPoint.zero

    func apply(toBoid boid:Boid, inFlock flock:[Boid], withCenterOfMass centerOfMass: CGPoint) {
        self.velocity = centerOfMass
        self.velocity -= (boid.position / CGFloat(flock.count))
        self.velocity = (self.velocity - boid.position) / 300
    }
}

/**
 Separation
 
 - This behavior applies a tendency to move away from
 neighboring boids when they get too close together
 **/
class Separation: Behavior {
    var velocity: CGPoint = CGPoint.zero

    func apply(toBoid boid:Boid, inFlock flock:[Boid]) {
        self.velocity = CGPoint.zero
        
        for flockBoid in flock {
            guard flockBoid != boid else { continue }
            
            if boid.position.distance(from: flockBoid.position) < boid.radius {
                self.velocity -= (flockBoid.position - boid.position) / 20
            }
        }
    }
}

/**
 Alignment
 
 - This behavior applies a tendency for a boid to align its
 direction with the average direction of the entire flock
 **/
class Alignment: Behavior {
    var velocity: CGPoint = CGPoint.zero

    func apply(toBoid boid:Boid, inFlock flock:[Boid], withAlignment alignment: CGPoint) {
        self.velocity = alignment
        self.velocity -= (boid.velocity / CGFloat(flock.count))
        self.velocity += (self.velocity - boid.velocity) / 8
    }
}

/**
 Bound
 
 - This behavior applies a tendency for a boid to move away 
 from the edges of the screen within a sufficient margin
 **/
class Bound: Behavior {
    var velocity: CGPoint = CGPoint.zero

    func apply(toBoid boid:Boid, inFrame frame: CGRect) {
        self.velocity = CGPoint.zero

        let borderMargin = 100
        let xMin: CGFloat = CGFloat(borderMargin)
        let xMax: CGFloat = frame.size.width - CGFloat(borderMargin)
        let yMin: CGFloat = CGFloat(borderMargin)
        let yMax: CGFloat = frame.size.height - CGFloat(borderMargin)
        let borderTurnResistance: CGFloat = 2
        
        if boid.position.x < xMin {
            self.velocity.x += borderTurnResistance
        }
        if boid.position.x > xMax {
            self.velocity.x -= borderTurnResistance
        }
        
        if boid.position.y < yMin {
            self.velocity.y += borderTurnResistance
        }
        if boid.position.y > yMax {
            self.velocity.y -= borderTurnResistance
        }
    }
}
