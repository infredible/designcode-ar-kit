//
//  ViewController+ObjectAddition.swift
//  DesignCodeARKit
//
//  Created by Fred Zaw on 6/22/20.
//  Copyright © 2020 Fred Zaw. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension ViewController {
    
    fileprivate func getModel(named name: String) -> SCNNode? {
        let scene = SCNScene(named: "art.scnassets/\(name)/\(name).scn")
        guard let model = scene?.rootNode.childNode(withName: "SketchUp", recursively:
            false) else {return nil}
        model.name = name
        return model
    }
    
    @IBAction func addObjectButtonTapped(_ sender: Any) {
        print("Add button tapped")
        
        guard focusSquare != nil else {return}
        let modelName = "iPhoneX"
        guard let model = getModel(named: modelName) else {
            print("Unable to load \(modelName) from file")
            return
        }
        
        let hitTest = sceneView.hitTest(screenCenter, types: .existingPlaneUsingExtent)
        guard let worldTransformColumn3 = hitTest.first?.worldTransform.columns.3 else {return}
        model.position = SCNVector3(worldTransformColumn3.x, worldTransformColumn3.y, worldTransformColumn3.z)
        
        sceneView.scene.rootNode.addChildNode(model)
        print("\(modelName) added successfully")
        
        modelsInScene.append(model)
        print(modelsInScene.count)
        
        DispatchQueue.main.async {
                self.modelCounter.text = "\(self.modelsInScene.count) models"
        }
        
    }
    
    
    
}
