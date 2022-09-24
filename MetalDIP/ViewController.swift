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
    metalView = MTKView(frame: CGRect.zero, device: device)
    guard let metalView = metalView else { return }
    self.view = metalView
    renderer = Renderer(view: metalView)
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

