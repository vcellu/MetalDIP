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
  private var vertextBuffer: MTLBuffer?
  private var indexBuffer: MTLBuffer?
  private var commandQueue: MTLCommandQueue?
  private var pipelineState: MTLRenderPipelineState?
  private let pipelineDesc = MTLRenderPipelineDescriptor()
  
  init(view: MTKView, device: MTLDevice) {
    metalView = view
    commandQueue = device.makeCommandQueue()
    
    // Create our vertex data
    let vertices = [Vertex(color: [1, 0, 0, 1], pos: [-1, 1]),
                    Vertex(color: [0, 1, 0, 1], pos: [1, 1]),
                    Vertex(color: [0, 0, 1, 1], pos: [-1, -1]),
                    Vertex(color: [1, 0, 0, 1], pos: [1, -1]),
    ]
    
    let indices:[UInt16] = [
      0, 3, 2,
      0, 1, 3
    ]
    
    vertextBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride)
    indexBuffer = device.makeBuffer(bytes: indices, length: indices.count * MemoryLayout<UInt16>.stride)
    super.init()
    metalView.delegate = self
    metalView.enableSetNeedsDisplay = true
    metalView.clearColor = MTLClearColorMake(0.39, 0.58, 0.93, 1.00)
    
    guard let library = device.makeDefaultLibrary() else { return }
    do {
      pipelineDesc.vertexFunction = library.makeFunction(name: "vertexShader")
      pipelineDesc.fragmentFunction = library.makeFunction(name: "fragmentShader")
      pipelineDesc.colorAttachments[0].pixelFormat = view.colorPixelFormat
      pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDesc)
    } catch {
      print("can't create pipeline \(error)")
    }
  }
  
  func draw(in view: MTKView) {
    guard
      let commandQueue = commandQueue,
      let renderDescriptor = metalView.currentRenderPassDescriptor,
      let commandBuffer = commandQueue.makeCommandBuffer(),
      let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor),
      let drawable = view.currentDrawable
    else {
      return
    }
    
    update(commandEncoder)
    
    commandEncoder.endEncoding()
    commandBuffer.present(drawable)
    commandBuffer.commit()
    
  }
  
  func update(_ encoder: MTLRenderCommandEncoder) {
    guard let pipelineState = pipelineState else { return }
    guard let indexBuffer = indexBuffer else { return }
    encoder.setRenderPipelineState(pipelineState)
    encoder.setVertexBuffer(vertextBuffer, offset: 0, index: 0)
    encoder.drawIndexedPrimitives(type: .triangle, indexCount: 6, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
  }
  
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    
  }
}
