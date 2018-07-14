//
//  PidsIcon.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 05.05.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import Foundation
class PidDisplayManager{
    
    static func image(for pid: Int)->(String){
        var imageName = ""
        switch pid {
        case 4:
            imageName = "Eng Load"
        case 14:
            imageName = "Piston"
        case 31:
            imageName = "Time"
        case 33:
            imageName = "Check"
        case 47:
            imageName = "Fuel Level"
        case 5:
            imageName = "Cool Temp"
        case 12:
            imageName = "RPM"
        case 13:
            imageName = "Speed"
        case 51:
            imageName = "Presure"
        case 70:
            imageName = "Temperature"
        default:
            imageName = "No Icon"
        }
        return imageName
    }
    
    static func description(for pid: Int)->(String){
        var pidDescription = ""
        switch pid {
        case 4:
            pidDescription = "Calculated engine load"
        case 14:
            pidDescription = "Timing advance"
        case 31:
            pidDescription = "Run time since engine start"
        case 33:
            pidDescription = "Distance traveled with malfunction indicator lamp (MIL) on"
        case 47:
            pidDescription = "Fuel Tank Level Input"
        case 48:
            pidDescription = "Warm-ups since codes cleared"
        case 49:
            pidDescription = "Distance traveled since codes cleared"
        case 5:
            pidDescription = "Engine coolant temperature"
        case 12:
            pidDescription = "Engine RPM"
        case 13:
            pidDescription = "Vehicle speed"
        case 51:
            pidDescription = "Absolute Barometric Pressure"
        case 70:
            pidDescription = "Ambient air temperature"
        default:
            pidDescription = "not suported Pid"
        }
        return pidDescription
    }
    
}
