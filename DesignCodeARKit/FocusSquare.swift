//
//  FocusSquare.swift
//  DesignCodeARKit
//
//  Created by Fred Zaw on 6/11/20.
//  Copyright © 2020 Fred Zaw. All rights reserved.
//

import SceneKit

class FocusSquare: SCNNode {
    var isClosed : Bool = true {
        didSet {
            geometry?.firstMaterial?.diffuse.contents = self.isClosed ? UIImage(named: "close") : UIImage(named: "open")
        }
    }
    
    override init() {
        super.init()
        
        let plane = SCNPlane(width: 0.1, height: 0.1)
        plane.firstMaterial?.diffuse.contents = UIImage(named: "close")
        plane.firstMaterial?.isDoubleSided = true
        
        geometry = plane
        eulerAngles.x = GLKMathDegreesToRadians(-90)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Hide and show FocusSquare
    func setHidden(to hidden: Bool) {
        var fadeTo: SCNAction
        
        if hidden {
            fadeTo = .fadeOut(duration: 0.5)
        } else {
            fadeTo = .fadeIn(duration: 0.5)
        }
        
        let actions = [fadeTo, .run({ (focusSquare:SCNNode) in
            focusSquare.isHidden = hidden
        })]
        runAction(.sequence(actions))
    }
}
