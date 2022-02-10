//
//  ShaderTestView.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/9/22.
//

import SwiftUI
import SpriteKit
import Shapes

struct ShaderTestView: View {
  @State private var polygonSides: Float = 3
  @State private var waveSpeed: Float = 3
  @State private var waveStrength: Float = 3
  @State private var waveFrequency: Float = 10
  @State private var scene = ShaderScene()
  
  var body: some View {
    GeometryReader { proxy in
      let dim = min(proxy.size.width, proxy.size.height)
      ZStack {
        LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
          .ignoresSafeArea()

        VStack {
          VStack {
            HStack {
              Text("Polygon Sides")
              Slider(value: $polygonSides, in: 3.0...20.0, step: 1.0)
            }
            Divider()
            HStack {
              Text("Speed")
              Slider(value: $waveSpeed, in: 0.0...10.0)
            }
            HStack {
              Text("Amplitude")
              Slider(value: $waveStrength, in: 0.0...5.0)
            }
            
            HStack {
              Text("Frequency")
              Slider(value: $waveFrequency, in: 0.0...25.0)
            }
          }
          .padding()
          .background(Color.white)
          .zIndex(1000)
          VStack {
            Text("Original")
              .fontWeight(.heavy)
              .foregroundColor(.white)
            textureView(sides: Int(polygonSides))
          }
          
          Divider()
          
          VStack {
            Text("Shader Applied")
              .fontWeight(.heavy)
              .foregroundColor(.white)
            
            SpriteView(
              scene: scene,
              options: [.allowsTransparency, .ignoresSiblingOrder]
            )
              .frame(width: dim, height: dim)
          }
          
          
        }
        .onChange(of: waveSpeed) { _ in
          updateShader()
        }
        .onChange(of: waveStrength) { _ in
          updateShader()
        }
        .onChange(of: waveFrequency) { _ in
          updateShader()
        }
        .onChange(of: polygonSides) { newValue in
          applyViewToScene(sides: Int(newValue))
        }
        .onAppear {
          applyViewToScene(sides: Int(polygonSides))
        }
      }
    }
  }
  
  func updateShader() {
    scene.updateShader(params: ShaderParams(speed: waveSpeed, strength: waveStrength, frequency: waveFrequency))
  }
  
  func textureView(sides: Int) -> some View {
    GeometryReader { proxy in
      let dim = min(proxy.size.width, proxy.size.height)
      ZStack {
        ConvexPolygon(sides: sides)
          .inset(by: dim * 0.15)
          .strokeBorder(lineWidth: dim * 0.1)
      }
      .frame(width: proxy.size.width, height: proxy.size.height)
    }
  }
  
  func applyViewToScene(sides: Int) {
    let image = textureView(sides: sides)
      .uiimage(rect:
        CGRect(
          origin: .zero,
          size: CGSize(width: 100, height: 100)
        )
      )
    
    scene.updateTextureImage(image)
  }
}

struct ShaderTestView_Previews: PreviewProvider {
  static var previews: some View {
    ShaderTestView()
  }
}
