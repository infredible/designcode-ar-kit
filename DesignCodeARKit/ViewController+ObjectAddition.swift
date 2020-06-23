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
    }
    
}
