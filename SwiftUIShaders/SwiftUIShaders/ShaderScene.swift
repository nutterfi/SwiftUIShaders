//
//  ShaderScene.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/9/22.
//

import SpriteKit

struct ShaderParams {
  var speed: Float
  var strength: Float
  var frequency: Float
}

class ShaderScene: SKScene {
  var aShader: SKShader?
  var node: SKSpriteNode = SKSpriteNode()
  
  override func sceneDidLoad() {
    backgroundColor = .clear
    self.anchorPoint = .zero
    scaleMode = .aspectFit
    aShader = createWater(params: ShaderParams(speed: 3, strength: 5, frequency: 5))
  }
  
  override func didMove(to view: SKView) {
    addChild(node)
    node.shader = aShader
    let dim = min(size.width, size.height)
    node.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
    node.scale(to: CGSize(width: dim * 0.8, height: dim * 0.8))
  }
  
  func updateTextureImage(_ image: UIImage) {
    let texture = SKTexture(image: image)
    texture.filteringMode = .nearest
    node.texture = texture
    node.size = image.size
    let dim = min(size.width, size.height)
    node.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
    node.scale(to: CGSize(width: dim * 0.8, height: dim * 0.8))
  }
  
  func updateShader(params: ShaderParams) {
    let newShader = createWater(params: params)
    aShader = newShader
    node.shader = newShader
  }
  
  func createWater(params: ShaderParams) -> SKShader {
    let uniforms: [SKUniform] = [
      SKUniform(name: "u_speed", float: params.speed),
      SKUniform(name: "u_strength", float: params.strength),
      SKUniform(name: "u_frequency", float: params.frequency)
    ]
    let shader = SKShader(fileNamed: "SHKWater")
    shader.uniforms = uniforms
    return shader
  }
  
}
