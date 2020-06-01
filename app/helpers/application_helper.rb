module ApplicationHelper
  require "redcarpet"
  require "coderay"
  def default_meta_tags
    {
      site: 'ケトサーチ - KetoSearch',
      title: 'グラフで最も分かりやすいオンライン栄養成分表示サービス',
      reverse: true,
      charset: 'utf-8',
      description: 
      '
      健康を気遣う人、病気で食事管理をする人、ダイエットを行う人のためのQRコードを用いたオンライン栄養成分表示サービス。
      2015年に施行された「食品表示法」から約5年、未だ飲食店における栄養成分表示は進化しておらず、IT化も全く進んでいません。
      また、既存のアナログな栄養成分表示は、ただ書いてあるだけといった感じで、全くお客様に対しての配慮がありません。
      そこでケトサーチでは、グラフや表などを用いて栄養成分に関して見える化するだけでなく、アレルギー物質やメニューの詳細情報などお客様が気になる情報をとことん見やすくしております。
      ケトサーチは、飲食店のメニューだけでなく、野菜などの食材や調味料の100gあたりの糖質・タンパク質・脂質などの情報検索や一覧表示、絞り込み検索などもできます。
      ',
      keywords: '飲食店, ファミレス, 栄養成分表示, アレルギー, 栄養成分, アレルギー物質, 栄養成分一覧, 糖質検索, ケトジェニック, ダイエット, 野菜 糖質, 糖質 一覧 100g, 糖質制限, ケトサーチ, ketosearch, ketogenic, diet, ローカーボ, ロカボ',
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

  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      language = language.split(':')[0]

      case language.to_s
      when 'rb'
        lang = 'ruby'
      when 'yml'
        lang = 'yaml'
      when 'css'
        lang = 'css'
      when 'html'
        lang = 'html'
      when ''
        lang = 'md'
      else
        lang = language
      end

      CodeRay.scan(code, lang).div
    end
  end

  def markdown(text)
    html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
    options = {
      autolink: true,
      space_after_headers: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      tables: true,
      hard_wrap: true,
      xhtml: true,
      lax_html_blocks: true,
      strikethrough: true
    }
    markdown = Redcarpet::Markdown.new(html_render, options)
    markdown.render(text)
  end
end
