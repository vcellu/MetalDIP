//
//  Renderer.swift
//  MetalDIP
//
//  Created by Vittorio Cellucci on 2022-09-24.
//

import Foundation
import MetalKit

class Renderer : NSObject, MTKViewDelegate {
 
  private var metalView: MTKView
  private var commandQueue: MTLCommandQueue?
  
  public init(view: MTKView, device: MTLDevice) {
    metalView = view
    commandQueue = device.makeCommandQueue()
    
    super.init()
    metalView.delegate = self
    metalView.clearColor = MTLClearColorMake(0.39, 0.58, 0.93, 1.00)
  }
  
  public func update() {
  }
  
  public func draw(in view: MTKView) {
    guard
      let commandQueue = commandQueue,
      let renderDescriptor = metalView.currentRenderPassDescriptor,
      let commandBuffer = commandQueue.makeCommandBuffer(),
      let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor),
      let drawable = view.currentDrawable
      else {
        return
      }
    
    self.update()
    
    commandEncoder.endEncoding()
    commandBuffer.present(drawable)
    commandBuffer.commit()
    
  }
  
  public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    
  }
}
