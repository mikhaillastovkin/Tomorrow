//
//  GameViewPresenter.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 10.03.2022.
//

import UIKit

protocol InputArticleViewController {
    var presenter: OutputArticleViewController { get set}
    func fillDataArticle(title: String?, image: UIImage?, subtitle: String?, attributeText: NSAttributedString?, props: String?)
    func setLikeButton(isLiked: Bool)
}

protocol OutputArticleViewController {
    var article: Article { get set }
    func pressLikeButton()
}

final class ArticleViewPresenter: OutputArticleViewController {
    var article: Article
    weak var inputView: (UIViewController & InputArticleViewController)? {
        didSet {
            fillView()
        }
    }

    init(artikle: Article) {
        self.article = artikle
    }

    func pressLikeButton() {
        let coreDataManager = CoreDataManager()
        coreDataManager.changeArtikleIsLike(article: article)
        checkArticleIsLike()
    }

    private func checkArticleIsLike() {
        inputView?.setLikeButton(isLiked: article.isLiked)
    }

    private func fillView() {
        checkArticleIsLike()
        let title = article.title
        let image = ImageBuilder().imageBuild(name: article.imgName)
        let props = article.props
        var subtitle = article.subtitle

        if subtitle == nil {
            subtitle = CategoryManager.getSubtitle(for: article.category)
        }

        if let htmlData = article.htmlData,
            let attributeText = try? NSMutableAttributedString(
                data: htmlData,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html],
                documentAttributes: nil) {
            inputView?.fillDataArticle(title: title, image: image, subtitle: subtitle, attributeText: attributeText, props: props)
        } else {
            let attributeText = NSAttributedString(string: article.text ?? "")
            inputView?.fillDataArticle(title: title, image: image, subtitle: subtitle, attributeText: attributeText, props: props)
        }
    }
}
