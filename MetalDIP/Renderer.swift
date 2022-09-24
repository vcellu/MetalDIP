//
//  Renderer.swift
//  MetalDIP
//
//  Created by Vittorio Cellucci on 2022-09-24.
//

import Foundation
import MetalKit

class Renderer : NSObject, MTKViewDelegate {
 
  public var metalView: MTKView
  
  public init(view: MTKView) {
    metalView = view
    super.init()
    metalView.delegate = self
  }
  
  public func update() {
  }
  
  public func draw(in view: MTKView) {
    self.update()
  }
  
  public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    
  }
}
