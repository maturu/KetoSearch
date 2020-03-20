module ApplicationHelper
  def default_meta_tags
    {
      site: 'ケトサーチ - KetoSearch',
      title: '糖質検索',
      reverse: true,
      charset: 'utf-8',
      description: 'ケトサーチは、食材や調味料の糖質・タンパク質・脂質などの情報を検索するためのサービスです。',
      keywords: '糖質検索, ケトジェニック, ダイエット, 野菜 糖質, 糖質一覧, 糖質制限, ケトサーチ, ketosearch, ketogenic, diet, ローカーボ, ロカボ',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.png') },
      ],
      og: {
        url: request.original_url,
        title: '糖質検索サービス「ケトサーチ-KetoSearch-」',
        description: :description,
        image: image_url('twitter-card.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@ketosearch',
      }
    }
  end
end
