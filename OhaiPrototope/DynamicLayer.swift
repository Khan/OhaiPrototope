//
//  DynamicLayer.swift
//  OhaiPrototope
//
//  Created by Nefaur Khandker on 2/5/15.
//  Copyright (c) 2015 Khan Academy. All rights reserved.
//

import Prototope

typealias Vector = Point

extension Vector {

    func normalized() -> Vector {
        let magnitude = self.length
        if (magnitude != 0) {
            return self / magnitude
        } else {
            return self
        }
    }

}

public class DynamicLayer: Layer {

    var mass: Double
    var velocity: Vector
    var forces: [String: Vector]
    var impulse: Vector

    var lastTimestamp: Timestamp
    var renderer: Heartbeat?

    var netForce: Vector {
        var force = Vector()
        for (key, f) in self.forces {
            force += f
        }
        return force
    }
    
    override init(parent: Layer? = nil, name: String? = nil) {
        mass = 1
        velocity = Vector()
        forces = Dictionary()
        impulse = Vector()
        lastTimestamp = Timestamp.currentTimestamp
        
        super.init(parent: parent, name: name)

        renderer = Heartbeat(handler: { heartbeat in
            let currentTimestamp = heartbeat.timestamp
            let dt = currentTimestamp - self.lastTimestamp
            self.lastTimestamp = currentTimestamp
            
            let acceleration = self.mass * (self.netForce + self.impulse)
            self.velocity += dt * acceleration
            self.position += dt * self.velocity
            
            self.impulse = Vector()
        })
    }
    
    func stop() {
        self.impulse = Vector()
        self.forces.removeAll()
        self.velocity = Vector()
    }
    
    func applyImpulse(impulse: Vector) {
        self.impulse += impulse
    }
    
    func applyForce(id: String, force: Vector) {
        self.forces[id] = force
    }
    
    func removeForce(id: String) {
        self.forces.removeValueForKey(id)
    }

}
