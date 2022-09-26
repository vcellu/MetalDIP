//
//  ViewController.swift
//  MetalDIP
//
//  Created by Vittorio Cellucci on 2022-09-24.
//

import Cocoa
import MetalKit


class ViewController: NSViewController {

  private var device: MTLDevice?
  private var metalView: MTKView?
  private var renderer: Renderer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    device = MTLCreateSystemDefaultDevice()
    metalView = MTKView(frame: self.view.frame, device: device)
    
    guard let metalView = metalView else { return }
    guard let device = device else { return }
    self.view.addSubview(metalView)
    metalView.autoresizingMask = [.height, .width]
    renderer = Renderer(view: metalView, device: device)
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }
}

