// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import UIKit

extension UIColor {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

extension UIColor {
  enum Name {
    /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e67e22"></span>
    /// Alpha: 100% <br/> (0xe67e22ff)
    case Carrot
    /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2ecc71"></span>
    /// Alpha: 100% <br/> (0x2ecc71ff)
    case Emerland
    /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3498db"></span>
    /// Alpha: 100% <br/> (0x3498dbff)
    case Peterriver
    /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c0392b"></span>
    /// Alpha: 100% <br/> (0xc0392bff)
    case Pomegranate

    var rgbaValue: UInt32! {
      switch self {
      case .Carrot: return 0xe67e22ff
      case .Emerland: return 0x2ecc71ff
      case .Peterriver: return 0x3498dbff
      case .Pomegranate: return 0xc0392bff
      }
    }
  }

  convenience init(named name: Name) {
    self.init(rgbaValue: name.rgbaValue)
  }
}

