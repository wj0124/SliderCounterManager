//
//  ButtonViewController.swift
//  SliderCounterManagerDemo
//
//  Created by 王杰 on 2024/12/20.
//

import UIKit

import UIKit

class ButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置视图背景颜色
        view.backgroundColor = .white

        // 创建按钮1：使用 play.fill 图标（开始）
        let button1 = UIButton(type: .system)
        button1.frame = CGRect(x: 50, y: 100, width: 300, height: 50)
        button1.center = CGPoint(x: view.center.x, y: 100)
        
        if #available(iOS 13.0, *) {
            // 配置不同的 SymbolConfiguration
            let iconConfig1 = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium)
            let icon1 = UIImage(systemName: "play.fill", withConfiguration: iconConfig1)
            button1.setImage(icon1, for: .normal)
            // 设置按钮标题（中文描述）
            button1.setTitle("点大小: 30, 粗细: 常规, 缩放: 中等", for: .normal)
        }

        // 创建按钮2：使用 pause.fill 图标（暂停）
        let button2 = UIButton(type: .system)
        button2.frame = CGRect(x: 50, y: 200, width: 300, height: 50)
        button2.center = CGPoint(x: view.center.x, y: 200)
        
        if #available(iOS 13.0, *) {
            // 配置不同的 SymbolConfiguration
            let iconConfig2 = UIImage.SymbolConfiguration(pointSize: 13, weight: .bold, scale: .large)
            let icon2 = UIImage(systemName: "pause.fill", withConfiguration: iconConfig2)
            button2.setImage(icon2, for: .normal)
            // 设置按钮标题（中文描述）
            button2.setTitle("点大小: 13, 粗细: 粗体, 缩放: 大", for: .normal)
        }

        // 创建按钮3：使用 play.fill 图标（开始）
        let button3 = UIButton(type: .system)
        button3.frame = CGRect(x: 50, y: 300, width: 300, height: 50)
        button3.center = CGPoint(x: view.center.x, y: 300)
        
        if #available(iOS 13.0, *) {
            // 配置不同的 SymbolConfiguration
            let iconConfig3 = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .small) // 提供默认值的 pointSize 和 weight
            let icon3 = UIImage(systemName: "play.fill", withConfiguration: iconConfig3)
            button3.setImage(icon3, for: .normal)
            // 设置按钮标题（中文描述）
            button3.setTitle("点大小: 25, 粗细: 常规, 缩放: 小", for: .normal)
        }

        // 创建按钮4：使用 pause.fill 图标（暂停）
        let button4 = UIButton(type: .system)
        button4.frame = CGRect(x: 50, y: 400, width: 300, height: 50)
        button4.center = CGPoint(x: view.center.x, y: 400)
        
        if #available(iOS 13.0, *) {
            // 使用一个有效的默认配置
            let iconConfig4 = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium) // 提供默认配置
            let icon4 = UIImage(systemName: "pause.fill", withConfiguration: iconConfig4)
            button4.setImage(icon4, for: .normal)
            // 设置按钮标题（中文描述）
            button4.setTitle("点大小: 30, 粗细: 常规, 缩放: 中等", for: .normal)
        }

        // 设置按钮的标题自适应大小
        [button1, button2, button3, button4].forEach {
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.lineBreakMode = .byWordWrapping
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }

        // 添加按钮到视图
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
    }
}
