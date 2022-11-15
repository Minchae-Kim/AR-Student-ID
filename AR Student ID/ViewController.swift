//
//  ViewController.swift
//  AR Student ID
//
//  Created by 김민채 on 2022/10/06.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    var name_data: String?
    var age_data: String?
    var image_data: UIImage?
    
    var dataNodes: [SCNNode] = []

    var dicPos: [String: SCNVector3] = ["name": SCNVector3(x: 0, y: 0, z: 0), "age": SCNVector3(x: 0, y: 0, z: 0), "image": SCNVector3(x: 0, y: 0, z: 0)]
    
    var sceneView: ARSCNView!
    
    var topNode: SCNNode!
    
    var imgWidth: CGFloat!
    var imgHeight: CGFloat!
    
    var topBoxNodes: [SCNNode] = []
    var bottomBoxNodes: [SCNNode] = []
    var leftBoxNodes: [SCNNode] = []
    var rightBoxNodes: [SCNNode] = []
    
    var touchedNode: SCNNode!
    
    var selectedNode: SCNNode!
    var isAdjusting: Bool! = false
    
    var commercialPopUp: PopUp!
    
    @IBOutlet var PopBtn: UIBarButtonItem!
    @IBOutlet var doneBtn: UIBarButtonItem!
    
    var moveBtns: [UIBarButtonItem] = []
    @IBOutlet var movePlusXBtn: UIBarButtonItem!
    @IBOutlet var moveMinusXBtn: UIBarButtonItem!
    @IBOutlet var movePlusYBtn: UIBarButtonItem!
    @IBOutlet var moveMinusYBtn: UIBarButtonItem!
    @IBOutlet var movePlusZBtn: UIBarButtonItem!
    @IBOutlet var moveMinusZBtn: UIBarButtonItem!
    
    
    @IBAction func movePlusXBtnTapped(_ sender: Any) {
        if selectedNode != nil {
            dicPos[selectedNode.name!]?.x += 0.005
        }
    }
    
    @IBAction func moveMinusXBtnTapped(_ sender: Any) {
        if selectedNode != nil {
            dicPos[selectedNode.name!]?.x -= 0.005
        }
    }
    
    @IBAction func movePlusYBtnTapped(_ sender: Any) {
        if selectedNode != nil {
            dicPos[selectedNode.name!]?.y += 0.005
        }
    }
    
    @IBAction func moveMinusYBtnTapped(_ sender: Any) {
        if selectedNode != nil {
            dicPos[selectedNode.name!]?.y -= 0.005
        }
    }
    
    @IBAction func movePlusZBtnTapped(_ sender: Any) {
        if selectedNode != nil {
            dicPos[selectedNode.name!]?.z += 0.005
        }
    }
    
    @IBAction func moveMinusZBtnTapped(_ sender: Any) {
        if selectedNode != nil {
            dicPos[selectedNode.name!]?.z -= 0.005
        }
    }
    
    
    
    @IBAction func PopBtnTapped(_ sender: Any) {
        self.commercialPopUp = PopUp(frame: self.view.frame)
        self.commercialPopUp.addNameBtn.addTarget(self, action: #selector(addName), for: .touchUpInside)
        self.commercialPopUp.addAgeBtn.addTarget(self, action: #selector(addAge), for: .touchUpInside)
        self.commercialPopUp.addImageBtn.addTarget(self, action: #selector(addImage), for: .touchUpInside)

        self.view.addSubview(commercialPopUp)
    }
    
    func OnAdjustingMode() {
        isAdjusting = true
        PopBtn.isHidden = true
        doneBtn.isHidden = false
        for btns in moveBtns {
            btns.isHidden = false
        }
    }
    
    func OffAdjustingMode() {
        isAdjusting = false
        PopBtn.isHidden = false
        doneBtn.isHidden = true
        for btns in moveBtns {
            btns.isHidden = true
        }
    }
    
    @objc func addName() {
        for node in dataNodes {
            if node.name == "name" {
                selectedNode = node
            }
        }
        
        OnAdjustingMode()
        
        topBoxNodes[0].opacity = 0.5
        bottomBoxNodes[0].opacity = 0.5
        leftBoxNodes[0].opacity = 0.5
        rightBoxNodes[0].opacity = 0.5
        
        self.commercialPopUp.removeFromSuperview()
    }
    
    @objc func addAge() {
        for node in dataNodes {
            if node.name == "age" {
                selectedNode = node
            }
        }
        
        OnAdjustingMode()
        
        topBoxNodes[0].opacity = 0.5
        bottomBoxNodes[0].opacity = 0.5
        leftBoxNodes[0].opacity = 0.5
        rightBoxNodes[0].opacity = 0.5
        
        self.commercialPopUp.removeFromSuperview()
    }
    
    @objc func addImage() {
        for node in dataNodes {
            if node.name == "image" {
                selectedNode = node
            }
        }
        
        OnAdjustingMode()
        
        topBoxNodes[0].opacity = 0.5
        bottomBoxNodes[0].opacity = 0.5
        leftBoxNodes[0].opacity = 0.5
        rightBoxNodes[0].opacity = 0.5
        
        self.commercialPopUp.removeFromSuperview()
    }
    
    
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        OffAdjustingMode()
        
        for node in topBoxNodes {
            node.opacity = 0
        }
        for node in bottomBoxNodes {
            node.opacity = 0
        }
        for node in leftBoxNodes {
            node.opacity = 0
        }
        for node in rightBoxNodes {
            node.opacity = 0
        }
        
        selectedNode = nil
        touchedNode = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = ARSCNView()
        
        self.view.addSubview(sceneView)
        
        // add autolayout constraints
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sceneView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.autoenablesDefaultLighting = true
        
        gestureRecognizer()
    
        doneBtn.isHidden = true
        
        moveBtns.append(movePlusXBtn)
        moveBtns.append(moveMinusXBtn)
        moveBtns.append(movePlusYBtn)
        moveBtns.append(moveMinusYBtn)
        moveBtns.append(movePlusZBtn)
        moveBtns.append(moveMinusZBtn)
        for btns in moveBtns {
            btns.isHidden = true
        }
        
        // image
        image_data = UIImage(named: "img.jpg")
    }

    
    private func gestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapped(recognizer: UITapGestureRecognizer) {
        let sceneView = recognizer.view as! SCNView
        let touchLocation = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: [:])

        if !hitResults.isEmpty {
            touchedNode = hitResults[0].node
            //print(touchedNode.name! as String)
            
//            if !isAdjusting {
//                for node in dataNodes {
//                    if touchedNode.name == node.name {
//                        selectedNode = node
//                        print("ha")
//                        OnAdjustingMode()
//                    }
//                }
//            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        topNode = SCNNode()
        
        guard let imageAnchor = anchor as? ARImageAnchor else {return nil}
        guard let imageName = imageAnchor.referenceImage.name else {return nil}
        imgWidth = imageAnchor.referenceImage.physicalSize.width
        imgHeight = imageAnchor.referenceImage.physicalSize.height
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0)
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi/2
        
        topNode.addChildNode(planeNode)
        
        if imageName == "studentid" {
            createBigBoxes()
            createSmallBoxes()
        }
        
        createDataNode(type: "name", content: name_data!)
        createDataNode(type: "age", content: age_data!)
        createImageNode(type: "image")
        
        return topNode
    }
    
    func createDataNode(type: String, content: String) {
        let geometry  = SCNText(string: content, extrusionDepth: 1)
        geometry.firstMaterial?.diffuse.contents = UIColor.black
        
        let node = SCNNode(geometry: geometry)
        node.name = type
        
        let fontSize = Float(0.001)
        node.scale = SCNVector3(fontSize, fontSize, fontSize)
        
        let (min, max) = (geometry.boundingBox.min, geometry.boundingBox.max)
        let dx = min.x + 0.5 * (max.x - min.x)
        let dy = min.y + 0.5 * (max.y - min.y)
        let dz = min.z + 0.5 * (max.z - min.z)
        node.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
        node.opacity = 0
        
        dataNodes.append(node)
        topNode.addChildNode(node)
    }
    
    func createImageNode(type: String) {
        let w = image_data!.size.width
        let h = image_data!.size.height
        
        let node = SCNNode(geometry: SCNPlane(width: w*0.00005, height: h*0.00005))
        node.geometry?.firstMaterial?.diffuse.contents = image_data
        node.name = type
        node.opacity = 0
        
        dataNodes.append(node)
        topNode.addChildNode(node)
    }
    
    func createBigBoxes() {
        if let topBox1Node = boxNode(width: imgWidth, height: 0.04, length: imgHeight, color: UIColor.red, name: "topBox1", posX: 0, posY: 0.02, posZ: -Float(imgHeight)) {
            topBoxNodes.append(topBox1Node)
            topNode.addChildNode(topBox1Node)
        }
        
        if let bottomBox1Node = boxNode(width: imgWidth, height: 0.04, length: imgHeight, color: UIColor.blue, name: "bottomBox1", posX: 0, posY: 0.02, posZ: Float(imgHeight)) {
            bottomBoxNodes.append(bottomBox1Node)
            topNode.addChildNode(bottomBox1Node)
        }
        
        if let leftBox1Node = boxNode(width: imgWidth, height: 0.04, length: imgHeight, color: UIColor.green, name: "leftBox1", posX: -Float(imgWidth), posY: 0.02, posZ: 0) {
            leftBoxNodes.append(leftBox1Node)
            topNode.addChildNode(leftBox1Node)
        }
        
        if let rightBox1Node = boxNode(width: imgWidth, height: 0.04, length: imgHeight, color: UIColor.yellow, name: "rightBox1", posX: Float(imgWidth), posY: 0.02, posZ: 0) {
            rightBoxNodes.append(rightBox1Node)
            topNode.addChildNode(rightBox1Node)
        }
    }
    
    func createSmallBoxes() {
        if let topBox2Node = boxNode(width: imgWidth, height: 0.04, length: 0.005, color: UIColor.red, name: "topBox2", posX: 0, posY: 0.02, posZ: -Float(imgHeight/2+0.0025)) {
            topBox2Node.opacity = 0
            topBoxNodes.append(topBox2Node)
            topNode.addChildNode(topBox2Node)
        }
        
        if let topBox3Node = boxNode(width: imgWidth, height: 0.005, length: imgHeight, color: UIColor.red, name: "topBox3", posX: 0, posY: 0.0025, posZ: -Float(imgHeight)) {
            topBox3Node.opacity = 0
            topBoxNodes.append(topBox3Node)
            topNode.addChildNode(topBox3Node)
        }
        
        
        if let bottomBox2Node = boxNode(width: imgWidth, height: 0.005, length: imgHeight, color: UIColor.blue, name: "bottomBox2", posX: 0, posY: 0.0025, posZ: Float(imgHeight)) {
            bottomBox2Node.opacity = 0
            bottomBoxNodes.append(bottomBox2Node)
            topNode.addChildNode(bottomBox2Node)
        }
        
        if let bottomBox3Node = boxNode(width: imgWidth, height: 0.04, length: 0.005, color: UIColor.blue, name: "bottomBox3", posX: 0, posY: 0.02, posZ: Float(imgHeight/2+0.0025)) {
            bottomBox3Node.opacity = 0
            bottomBoxNodes.append(bottomBox3Node)
            topNode.addChildNode(bottomBox3Node)
        }
        
        
        if let leftBox2Node = boxNode(width: imgWidth, height: 0.005, length: imgHeight, color: UIColor.green, name: "leftBox2", posX: -Float(imgWidth), posY: 0.0025, posZ: 0) {
            leftBox2Node.opacity = 0
            leftBoxNodes.append(leftBox2Node)
            topNode.addChildNode(leftBox2Node)
        }
        
        if let leftBox3Node = boxNode(width: 0.005, height: 0.04, length: imgHeight, color: UIColor.green, name: "leftBox3", posX: -Float(imgWidth/2), posY: 0.02, posZ: 0) {
            leftBox3Node.opacity = 0
            leftBoxNodes.append(leftBox3Node)
            topNode.addChildNode(leftBox3Node)
        }
        
        if let leftBox4Node = boxNode(width: imgWidth, height: 0.04, length: 0.005, color: UIColor.green, name: "leftBox4", posX: -Float(imgWidth), posY: 0.02, posZ: Float(imgHeight/2)) {
            leftBox4Node.opacity = 0
            leftBoxNodes.append(leftBox4Node)
            topNode.addChildNode(leftBox4Node)
        }
        
        
        if let rightBox2Node = boxNode(width: imgWidth, height: 0.005, length: imgHeight, color: UIColor.yellow, name: "rightBox2", posX: Float(imgWidth), posY: 0.0025, posZ: 0) {
            rightBox2Node.opacity = 0
            rightBoxNodes.append(rightBox2Node)
            topNode.addChildNode(rightBox2Node)
        }
        
        if let rightBox3Node = boxNode(width: 0.005, height: 0.04, length: imgHeight, color: UIColor.yellow, name: "rightBox3", posX: Float(imgWidth/2), posY: 0.02, posZ: 0) {
            rightBox3Node.opacity = 0
            rightBoxNodes.append(rightBox3Node)
            topNode.addChildNode(rightBox3Node)
        }
        
        if let rightBox4Node = boxNode(width: imgWidth, height: 0.04, length: 0.005, color: UIColor.yellow, name: "rightBox4", posX: Float(imgWidth), posY: 0.02, posZ: Float(imgHeight/2)) {
            rightBox4Node.opacity = 0
            rightBoxNodes.append(rightBox4Node)
            topNode.addChildNode(rightBox4Node)
        }
    }
    
    func boxNode(width: CGFloat, height: CGFloat, length: CGFloat, color: UIColor, name: String, posX: Float, posY: Float, posZ: Float) -> SCNNode? {
        let box = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
        box.firstMaterial?.diffuse.contents = color
        
        let boxNode = SCNNode(geometry: box)
        boxNode.name = name
        boxNode.opacity = 0
        boxNode.position = SCNVector3(posX, posY, posZ)
        
        return boxNode
    }
    
    func allBoxesInvisible() {
        for i in 0..<topBoxNodes.count {
            topBoxNodes[i].opacity = 0
            bottomBoxNodes[i].opacity = 0
        }
        for i in 0..<leftBoxNodes.count {
            leftBoxNodes[i].opacity = 0
            rightBoxNodes[i].opacity = 0
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        
        if isAdjusting {
            if touchedNode != nil {
                if touchedNode.name == "topBox1" {
                    topBoxNodes[0].opacity = 0
                    for i in 1..<topBoxNodes.count {
                        topBoxNodes[i].opacity = 0.5
                    }
                }
                else if touchedNode.name == "bottomBox1" {
                    bottomBoxNodes[0].opacity = 0
                    for i in 1..<bottomBoxNodes.count {
                        bottomBoxNodes[i].opacity = 0.5
                    }
                }
                else if touchedNode.name == "leftBox1" {
                    leftBoxNodes[0].opacity = 0
                    for i in 1..<leftBoxNodes.count {
                        leftBoxNodes[i].opacity = 0.5
                    }
                }
                else if touchedNode.name == "rightBox1" {
                    rightBoxNodes[0].opacity = 0
                    for i in 1..<rightBoxNodes.count {
                        rightBoxNodes[i].opacity = 0.5
                    }
                }
                
                else if touchedNode.name == "topBox2" || touchedNode.name == "bottomBox3" || touchedNode.name == "leftBox4" || touchedNode.name == "rightBox4" {
                    allBoxesInvisible()
                    
                    selectedNode.opacity = 1
                    selectedNode.position = touchedNode.position
                    
                    selectedNode.position += dicPos[selectedNode.name!]!
                }
                
                else if touchedNode.name == "topBox3" || touchedNode.name == "bottomBox2" || touchedNode.name == "leftBox2" || touchedNode.name == "rightBox2" {
                    allBoxesInvisible()
                    
                    selectedNode.opacity = 1
                    selectedNode.position = touchedNode.position
                    selectedNode.eulerAngles.x = -.pi/2
                    
                    selectedNode.position += dicPos[selectedNode.name!]!
                }
                
                else if touchedNode.name == "leftBox3" {
                    allBoxesInvisible()
                    
                    selectedNode.opacity = 1
                    selectedNode.position = touchedNode.position
                    selectedNode.eulerAngles.y = -.pi/2
                    
                    selectedNode.position += dicPos[selectedNode.name!]!
                }
                
                else if touchedNode.name == "rightBox3" {
                    allBoxesInvisible()
                    
                    selectedNode.opacity = 1
                    selectedNode.position = touchedNode.position
                    selectedNode.eulerAngles.y = .pi/2
                    
                    selectedNode.position += dicPos[selectedNode.name!]!
                }
            }
        }
            
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
