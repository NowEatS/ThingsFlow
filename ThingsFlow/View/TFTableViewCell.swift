//
//  TFTableViewCell.swift
//  ThingsFlow
//
//  Created by TaeWon Seo on 2021/11/07.
//

import UIKit
import SnapKit
import Kingfisher

class TFTableViewCell: UITableViewCell {
    
    // MARK: - UIProperty
    private var indexLabel: UILabel = UILabel()
    private var cellImageView: UIImageView = UIImageView()
    
    // MARK: - Override Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        indexLabel.text = ""
        cellImageView.image = nil
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        indexLabel.text = ""
        cellImageView.image = nil
        
        setUpCell()
    }
    
    // MARK: - Custom Methods
    private func setUpCell() {
        contentView.addSubview(indexLabel)
        indexLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(16.0)
            make.left.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().offset(-16.0)
        }
        indexLabel.font = .systemFont(ofSize: 16.0)
        
        contentView.addSubview(cellImageView)
        cellImageView.image = UIImage(systemName: "chevron.right")
        cellImageView.contentMode = .scaleAspectFit
        cellImageView.snp.removeConstraints()
        cellImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16.0)
            make.width.height.equalTo(16.0)
            make.left.equalTo(indexLabel.snp.right).offset(8.0)
        }
        cellImageView.tintColor = .gray
    }
    
    func setIndex(_ index: String) {
        indexLabel.text = index
    }
    
    func setThingsFlowBanner() {
        indexLabel.snp.removeConstraints()
        indexLabel.removeFromSuperview()
        cellImageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(36.0)
        }
        cellImageView.kf.setImage(with:URL(string: TFContentsURL.ThingsFlow_Banner))
    }
}
