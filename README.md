# SliderCounterManager

一个高度可定制的轻量级步进控制视图，支持滑块值的实时调整以及播放/暂停动画功能。

---

## 功能特点

- **自定义界面**：可根据需求调整布局和样式。
- **步进增减功能**：通过按钮快速切换滑块值。
- **实时控制**：支持手动和自动更新滑块值。
- **播放/暂停控制**：无缝切换动画状态。
- **代理回调**：监听滑块值变化和动画状态切换。

---

## 系统要求

- iOS 13.0+
- Swift 5.0+
- SnapKit（用于布局管理）

---
## 示例代码

以下是一个完整的示例：
	

```import UIKit
import SnapKit

class ViewController: UIViewController {
    private let stepControlView = StepControlView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stepControlView)
        
        stepControlView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        
        stepControlView.delegate = self
    }
}

extension ViewController: StepControlViewDelegate {
    func stepControlView(didUpdateValue value: Float) {
        print("当前滑块值: \(value)")
    }

    func stepControlView(didChangeState state: SliderCounterManager.State) {
        print("当前状态: \(state)")
    }
}
```

## 自定义配置

StepControlView 提供多种配置接口，允许用户定制视图样式和功能：
- 最大值设置：通过初始化 SliderCounterManager 时指定 maxValue。
- 最小值设置：默认值为 0，可根据需求自定义。
- 动画间隔：通过设置 interval 调整自动更新频率。


