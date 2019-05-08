//
//  ProteinViewController.swift
//  Proteins
//
//  Created by Rapula MAAKE on 2018/11/20.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit
import SceneKit

class ProteinViewController: UIViewController {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var sceneKitView: SCNView!
    var sceneKitScene: SCNScene!
    var sceneKitNode: SCNNode!
    var name: String?
    var shareBtn: UIBarButtonItem!
    var tools = Tools()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        self.getAssets()
        self.title = "Ligand: " + self.name!
        // Do any additional setup after loading the view.
    }
    func initialize()
    {
        self.view = SCNView()
        self.sceneKitView = self.view as? SCNView
        self.sceneKitView.allowsCameraControl = true;
        self.sceneKitScene = SCNScene()
        self.sceneKitScene.background.contents = UIImage(named: "cool")
        self.sceneKitView.scene = self.sceneKitScene
        self.sceneKitView.isPlaying = true
        self.sceneKitNode = SCNNode()
        self.sceneKitNode.camera = SCNCamera()
        self.sceneKitNode.position = SCNVector3(x: 0, y: 0, z: 100)
       
        
        self.shareBtn = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(self.shareBtnAction))
        self.navigationItem.rightBarButtonItem = self.shareBtn
    }
    @objc func shareBtnAction()
    {
        let snap = self.sceneKitView.snapshot()
        let activityController = UIActivityViewController(activityItems: [snap], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    func getAssets()
    {
        let url = URL(string: "https://files.rcsb.org/ligands/view/" + self.name! + "_ideal.pdb")
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data:Data?, resp: URLResponse?, err: Error?) -> Void in
            if let data = data
            {
                
                let dat = String(data: data, encoding: String.Encoding.utf8)!
                self.tools.getAtom(str: dat)
                self.tools.getConnection(str: dat)
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.initialize()
                    self.drawInitialNodes()
                    self.drawConnection()
                }
                //print(dat);
            }
            else
            {
                ViewController.displayMessage(title: "Error", msg: "Failed to download lingad properties.\nReason: " + (err?.localizedDescription)!, view: self);
            }
        }).resume()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let tapped = touches.first!
        
        let position = tapped.location(in: self.sceneKitView)
        let tappedItems = self.sceneKitView.hitTest(position, options: nil)
        if let  tappedItem = tappedItems.first
        {
            let tappedNode = tappedItem.node
            if tappedNode.name != "StickNode"
            {
                ViewController.displayMessage(title: "Ligand Info", msg: "Atom Symbol: " + tappedNode.name!, view: self)
            }
        }
        
    }
    func drawInitialNodes()
    {
        let nodes = self.tools.getNodes()
        for node in nodes
        {
            let nodeItem:SCNGeometry = SCNSphere(radius: 0.5)
            nodeItem.materials.first?.diffuse.contents = node.color
            let nodeSphere = SCNNode(geometry: nodeItem)
            nodeSphere.position = node.vector
            nodeSphere.name = node.name
            self.sceneKitScene.rootNode.addChildNode(nodeSphere)
            //ballStickList.append(nodeSphere)
        }
    }
    func drawConnection()
    {
        let conns = self.tools.getConnections()
        for conn in conns
        {
            
            let stick:SCNGeometry = SCNCylinder(radius: 0.1, height: CGFloat(conn.distance!))
                stick.firstMaterial?.diffuse.contents = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
            let node = SCNNode()
            node.position = conn.node.vector
            
            let alignNode = SCNNode()
            alignNode.eulerAngles.x = Float(Double.pi / 2)
            let stickNode = SCNNode(geometry: stick)
            stickNode.position.y = -conn.distance / 2
            stickNode.name = "StickNode"
            alignNode.addChildNode(stickNode)
            alignNode.name = "alinNode"
            node.addChildNode(alignNode)
            node.name = "Node"
            
            let secNode = SCNNode()
            secNode.position = conn.adjNode.vector
            node.constraints = [SCNLookAtConstraint(target: secNode)]
            self.sceneKitScene.rootNode.addChildNode(node)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
