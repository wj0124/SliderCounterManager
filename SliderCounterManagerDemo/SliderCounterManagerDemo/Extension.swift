//
//  Untitled.swift
//  SliderCounterManagerDemo
//
//  Created by 王杰 on 2024/12/20.
//
import UIKit

extension UIImage {

    /// 上一个􁋯
    static var sf_backward: UIImage? {
        UIImage.init(systemName: "backward.end.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
    }
    
    /// 下一个􁋱
    static var sf_forward: UIImage? {
        UIImage.init(systemName: "forward.end.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
    }
    
    /// 点击播放 􀊕
    static var sf_play: UIImage? {
        UIImage.init(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
    }
    
    /// 暂停空心 􀊗
    static var sf_pause: UIImage? {
        UIImage.init(systemName: "pause.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
    }
    
}
