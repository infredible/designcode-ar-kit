//
//  ViewController+ARSCNViewDelegate.swift
//  DesignCodeARKit
//
//  Created by Fred Zaw on 6/10/20.
//  Copyright © 2020 Fred Zaw. All rights reserved.
//

import SceneKit
import ARKit

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return}
//        print("Horizontal surface detected")
        
//        let planeAnchor = anchor as! ARPlaneAnchor
//
//        let planeNode = createPlane(planeAnchor: planeAnchor)
//        node.addChildNode(planeNode)
        
        guard focusSquare == nil else {return}
        let focusSquareLocal = FocusSquare()
        sceneView.scene.rootNode.addChildNode(focusSquareLocal)
        focusSquare = focusSquareLocal
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return}
        print("Horizontal surface updated")
        
//        let planeAnchor = anchor as! ARPlaneAnchor
//
//        node.enumerateChildNodes {(childNode, _) in
//            childNode.removeFromParentNode()
//        }
//
//        let planeNode = createPlane(planeAnchor: planeAnchor)
//        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return}
//        print("Horizontal surface updated")
                
//        node.enumerateChildNodes {(childNode, _) in
//            childNode.removeFromParentNode()
//        }
    
    }
    
    // Make focus square shift as we go and update accordingly once per frame
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let focusSquareLocal = focusSquare else {return}
        
        let hitTest = sceneView.hitTest(screenCenter, types: .existingPlane)
        let hitTestResult = hitTest.first
        guard let worldTransform = hitTestResult?.worldTransform else {return}
        let worldTransformColumn3 = worldTransform.columns.3
        focusSquareLocal.position = SCNVector3(worldTransformColumn3.x, worldTransformColumn3.y, worldTransformColumn3.z)
        
        DispatchQueue.main.async {self.updateFocusSquare()}
        
    }
    
    
    func createPlane(planeAnchor: ARPlaneAnchor) -> SCNNode {
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        plane.firstMaterial?.diffuse.contents = UIImage(named: "grid")
        plane.firstMaterial?.isDoubleSided = true
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3 (planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
//        planeNode.eulerAngles.x = -.pi / 2
        planeNode.eulerAngles.x = GLKMathDegreesToRadians(-90)
        return planeNode
    }
}
