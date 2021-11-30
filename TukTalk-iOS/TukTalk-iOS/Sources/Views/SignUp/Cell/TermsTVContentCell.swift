//
//  TermsTVContentCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import UIKit

class TermsTVContentCell: UITableViewCell {
    
    public static let identifier : String = "TermsTVContentCell"
    
    var textView = UITextView().then {
        $0.isEditable = false
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(string: NSMutableAttributedString) {
        textView.attributedText = string
    }
    
    private func setUI() {
        backgroundColor = .white
        
        contentView.addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
