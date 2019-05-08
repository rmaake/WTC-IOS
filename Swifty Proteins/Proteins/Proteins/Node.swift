//
//  Node.swift
//  Proteins
//
//  Created by Rapula MAAKE on 2018/11/20.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import Foundation
import SceneKit

class Node
{
    var id:Int!
    var x:Float!
    var y:Float!
    var z:Float!
    var name:String!
    var symbol: String!
    var isPlotted:Bool!
    var vector: SCNVector3!
    var color: UIColor!
}

class Connection
{
    var node: Node!
    var adjNode: Node!
    var distance: Float!
}
