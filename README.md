<img src="/Artwork/boids.png" width="420">

#### Two dimensional implementation of Boids using SpriteKit and Swift 4.

###### Now with more emotes! š š š¦

## Overview
Boids is an algorithm for simulating natural group flocking behavior.  Flocking is an emergent behavior accomplished by applying a set of simple rules on autonomous agents, called "boids".  Each boid operates independently, assessing its surrounding flock and adjusting its heading based on an evaluation of a set of basic rules.
<br /><br /><img src="http://img.shields.io/badge/License-MIT-red.svg"> <img src="http://img.shields.io/badge/Platforms-iOS-lightgrey.svg"> <img src="https://img.shields.io/badge/Swift-4.0-orange.svg">

## Rules
The standard flocking rules:

> **1. Cohesion:** Steer toward the average position of nearby agents <br/><br/>**2. Alignment:** Maintain a heading similar to the average heading of nearby agents<br/><br/>**3. Separation:** Steer away from agents that are close to avoid crowding


In addition to the standard flocking rules, I've added:

> **4. Bound:** Steer away from the bounds of the device screen to keep agents in view


## Interaction

A touch adds a temporary rule:

> **6. Seek:** Move toward the current touch position

A force touch adds a temporary rule:

> **7. Evade:** Move away from the current touch position


## Preview

<img src="/Artwork/demo.gif" width="660">

## Usage
```swift
// Initialize and add a Boid SpriteNode to the Scene
let boid = Boid(withCharacter: "š”", andSize: 40)
addChild(boid)
```

```swift
// Configure the boid's behaviors.. or don't; whatever, it's your life
self.behaviors = [Cohesion(intensity: 0.1), Separation(intensity: 0.1), Alignment(intensity: 1.0)]
```

## Performance
Because each boid needs to iterate over the entire group, this runs in quadratic time _O(nĀ²)_.  As a benchmark, the iPhone X can maintain 60fps when simulating up to 150 boids.


## Source Versioning
* Xcode 10.1
* iOS SDK 12
* Swift 4.2

## Credit

**Original Paper:** Craig W. Reynolds (1987). [Flocks, Herds, and Schools:
A Distributed Behavioral Model](http://www.cs.toronto.edu/~dt/siggraph97-course/cwr87/)

**Pseudocode:** Conrad Parker (2007). [Boids Pseudocode](http://www.kfish.org/boids/pseudocode.html)
