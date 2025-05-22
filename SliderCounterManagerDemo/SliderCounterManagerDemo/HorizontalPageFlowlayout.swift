//
//  HorizontalPageFlowlayout.swift
//  YXTeacher
//
//  Created by 张伟 on 2021/5/16.
//  Copyright © 2021 YJJ－CHY. All rights reserved.
//

import UIKit

class HorizontalPageFlowlayout: UICollectionViewFlowLayout {
    /** 列间距 */
    var columnSpacing: CGFloat = 0
    /** 行间距 */
    var rowSpacing: CGFloat = 0
    /** collectionView的内边距 */
    var edgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    

    /** 多少行 */
    var rowCount: Int = 1
    /** 每行展示多少个item */
    var itemCountPerRow: Int = 1

    /** 所有item的属性数组 */
    lazy var attributesArrayM: [UICollectionViewLayoutAttributes] = {
        return [UICollectionViewLayoutAttributes]()
    }()
    
    
    init(rowCount: Int, itemCountPerRow: Int, columnSpacing:CGFloat, rowSpacing:CGFloat, edgeInsets: UIEdgeInsets) {
        super.init()
        self.rowCount = rowCount
        self.itemCountPerRow = itemCountPerRow
        self.columnSpacing = columnSpacing
        self.rowSpacing = rowSpacing
        self.edgeInsets = edgeInsets
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()

        let itemTotalCount = collectionView?.numberOfItems(inSection: 0) ?? 0

        for i in 0..<itemTotalCount {
            let indexpath = IndexPath(item: i, section: 0)
            let attributes = layoutAttributesForItem(at: indexpath)
            if let attributes = attributes {
                attributesArrayM.append(attributes)
            }
        }
    }
    
    /** 计算collectionView的滚动范围 */
    override var collectionViewContentSize: CGSize {
        // 从collectionView中获取到有多少个item
        let itemTotalCount = collectionView?.numberOfItems(inSection: 0)
        // 理论上每页展示的item数目
        let itemCount = rowCount * itemCountPerRow
        // 余数（用于确定最后一页展示的item个数）
        let remainder = (itemTotalCount ?? 0) % itemCount
        // 除数（用于判断页数）
        var pageNumber = (itemTotalCount ?? 0) / itemCount
        // 总个数小于self.rowCount * self.itemCountPerRow
        if (itemTotalCount ?? 0) <= itemCount {
            pageNumber = 1
        }else {
            if (remainder == 0) {

            }else {
                // 余数不为0,除数加1
                pageNumber = pageNumber + 1;
            }
        }
    
//        let width = (collectionView?.frame.size.width ?? 0.0) - 200
        let width = (collectionView?.frame.size.width ?? 0.0)
//        let width = 200
        let height = itemSize.height * CGFloat(rowCount) + edgeInsets.top + edgeInsets.bottom + rowSpacing
        return CGSize.init(width: Int(width) * pageNumber, height: Int(height))

    }
    
    /** 设置每个item的属性(主要是frame) */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let width = collectionView?.frame.size.width ?? 0
        let height = collectionView?.frame.size.height ?? 0
        
        let left = edgeInsets.left
        let right = edgeInsets.right
        let top = edgeInsets.top
        let bottom = edgeInsets.bottom
                
        let spacingWidth = CGFloat((itemCountPerRow - 1)) * columnSpacing
        let widths = width - left - right - spacingWidth
        // 计算出item的宽度
        let itemWidth = widths / CGFloat(itemCountPerRow)
        
        let spacingHeight = CGFloat((rowCount - 1)) * rowSpacing
        let heights = height - top - bottom - spacingHeight
        // 计算出item的宽度
        let itemHeight = heights / CGFloat(rowCount)
        
        let item = indexPath.item
        // 当前item所在的页
        let pageNumber = item / (rowCount * itemCountPerRow)
        let x = item % itemCountPerRow + pageNumber * itemCountPerRow
        let y = item / itemCountPerRow - pageNumber * rowCount
        
        // 计算出item的坐标
        let itemX = left * CGFloat(pageNumber + 1) + (itemWidth + columnSpacing) * CGFloat(x)
        let itemY = top + (itemHeight + rowSpacing) * CGFloat(y)
        
        // 每个item的frame
        let attributes = super.layoutAttributesForItem(at: indexPath)
        attributes?.frame = CGRect.init(x: itemX, y: itemY, width: itemWidth, height: itemHeight)

        return attributes
    }
    
    /** 返回collectionView视图中所有视图的属性数组 */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArrayM
    }
    

}
