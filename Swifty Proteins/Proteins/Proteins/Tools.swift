//
//  Tools.swift
//  Proteins
//
//  Created by Rapula MAAKE on 2018/11/21.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import Foundation
import SceneKit
class Tools
{
    private var nodes: [Node] = []
    private var connections: [Connection] = []
    public func getAtom(str: String)
    {
        let lines = str.split(separator: "\n")
        for line in lines
        {
            if (line.range(of: "ATOM") != nil)
            {
                let part = line.split(separator: " ")
                let node = Node()
                node.id = Int(part[1])
                node.name = String(part[11])
                node.symbol = String(part[11])
                node.x = Float(part[6])
                node.y = Float(part[7])
                node.z = Float(part[8])
                node.isPlotted = false
                node.vector = SCNVector3(node.x, node.y, node.z)
                node.color = self.CPKColorCalculator(node.symbol)
                self.nodes.append(node)
            }
        }
    }
    public func getConnection(str: String)
    {
        let lines = str.split(separator: "\n")
        for line in lines
        {
            if (line.range(of: "CONECT") != nil)
            {
                let parts = line.split(separator: " ")
                var i = 0
                for part in parts
                {
                    if (i > 1)
                    {
                        let conn = Connection()
                        conn.node = getNodeById(id: Int(parts[1])!)
                        conn.adjNode = getNodeById(id: Int(part)!)
                        conn.distance = distanceCalculator(n1: conn.node, n2: conn.adjNode) + 0.25
                        if (self.search(id1: Int(parts[1])!, id2: Int(part)!) == false)
                        {
                            self.connections.append(conn)
                        }
                        
                    }
                    i = i + 1;
                }
            }
        }
    }
    public func getNodes() -> [Node]
    {
        return self.nodes
    }
    public func getConnections() -> [Connection]
    {
        return self.connections
    }
    private func search(id1: Int, id2: Int) -> Bool
    {
        for conn in self.connections
        {
            if (conn.node.id == id1 && conn.adjNode.id == id2)
            {
                return true
            }
            if (conn.node.id == id2 && conn.adjNode.id == id1)
            {
                return true
            }
        }
        return false
    }
    private func getNodeById(id: Int) -> Node?
    {
        for node in self.nodes
        {
            if (node.id == id)
            {
                return node
            }
        }
        return nil
    }
    private func distanceCalculator(n1: Node, n2: Node) -> Float
    {
        let dx = n1.x - n2.x
        let dy = n1.y - n2.y
        let dz = n1.z - n2.z
        return sqrt((dx * dx) + (dy * dy) + (dz * dz))
    }
    private func CPKColorCalculator(_ symbol: String)->UIColor
    {
        switch symbol
        {
        case "H":
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        case "C":
            return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        case "N":
            return UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
        case "O":
            return UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        case "F", "CL" :
            return UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)
        case "BR":
            return UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1)
        case "I":
            return UIColor(red: 148/255, green: 0/255, blue: 211/255, alpha: 1)
        case "HE", "NE", "AR", "XE", "KR":
            return UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1)
        case "P":
            return UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1)
        case "S":
            return UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)
        case "B":
            return UIColor(red: 250/255, green: 128/255, blue: 114/255, alpha: 1)
        case "LI", "NA", "K", "RB", "CS", "FR":
            return UIColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1)
        case "BE", "MG", "CA", "SR", "BA", "RA":
            return UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1)
        case "TI":
            return UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        case "FE":
            return UIColor(red: 255/255, green: 76/255, blue: 0/255, alpha: 1)
        default:
            return UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 1)
        }
    }
}
