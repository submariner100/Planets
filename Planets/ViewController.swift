//
//  ViewController.swift
//  Planets
//
//  Created by Macbook on 18/09/2017.
//  Copyright © 2017 Chappy-App. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

	@IBOutlet weak var sceneView: ARSCNView!
	
	var configuration = ARWorldTrackingSessionConfiguration()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.sceneView.session.run(configuration)
		self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
		self.sceneView.autoenablesDefaultLighting = true
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		
		let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
		let earthParent = SCNNode()
		let venusParent = SCNNode()
		let moonParent = SCNNode()
		
		sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun Diffuse")
		sun.position = SCNVector3(0, 0,-1)
		
		earthParent.position = SCNVector3(0, 0, -1)
		venusParent.position = SCNVector3(0, 0 ,-1)
		moonParent.position = SCNVector3(1.2, 0, 0)
		
		self.sceneView.scene.rootNode.addChildNode(sun)
		self.sceneView.scene.rootNode.addChildNode(earthParent)
		self.sceneView.scene.rootNode.addChildNode(venusParent)
		
		let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth Diffuse"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2, 0, 0))
		let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Diffuse"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7,0,0))
		let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
		//let venusMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
		
		let sunAction = Rotation(time: 8)
		let earthParentRotation = Rotation(time: 14)
		let venusParentRotation = Rotation(time: 10)
		let earthRotation = Rotation(time: 8)
		let venusRotation = Rotation(time: 8)
		let moonRotation = Rotation(time: 5)
		
		earth.runAction(earthRotation)
		venus.runAction(venusRotation)
		earthParent.runAction(earthParentRotation)
		venusParent.runAction(venusParentRotation)
		sun.runAction(sunAction)
		moonParent.runAction(moonRotation)
		
		earthParent.addChildNode(earth)
		earthParent.addChildNode(moonParent)
		venusParent.addChildNode(venus)
		earth.addChildNode(moon)
		moonParent.addChildNode(moon)
		//venus.addChildNode(venusMoon)
		
	}
	
	func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
		let planet = SCNNode(geometry: geometry)
		
		planet.geometry?.firstMaterial?.diffuse.contents = diffuse
		planet.geometry?.firstMaterial?.specular.contents = specular
		planet.geometry?.firstMaterial?.emission.contents = emission
		planet.geometry?.firstMaterial?.normal.contents = normal
		planet.position = position
		return planet
		
	}
	
	func Rotation(time: TimeInterval) -> SCNAction {
		let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
		let foreverRotation = SCNAction.repeatForever(Rotation)
		return foreverRotation
	}
}

extension Int {
	
	var degreesToRadians: Double { return Double(self) * .pi/180}
}


