module ApplicationHelper
  require "redcarpet"
  require "coderay"
  def default_meta_tags
    {
      site: 'ケトサーチ - KetoSearch',
      title: '糖質量などグラフで最も分かりやすい情報検索サービス',
      reverse: true,
      charset: 'utf-8',
      description: '理想の体型を実現するため、正しく楽しく糖質制限。ダイエット成功の秘訣/コツは、如何に期間を短く、効率よく減量できるかにかかっています。そのため、ケトサーチでは、極端な糖質制限ダイエットを推奨しているWebサービスになります。ケトサーチは、野菜などの食材や調味料の100gあたりの糖質・タンパク質・脂質などの情報を検索することができます。また、糖質制限中に食べても良い食材が一覧でわかりやすいように、糖質が少ない順の食材ランキングなどを確認できます。',
      keywords: '糖質検索, ケトジェニック, ダイエット, 野菜 糖質, 糖質 一覧 100g, 糖質制限, ケトサーチ, ketosearch, ketogenic, diet, ローカーボ, ロカボ',
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
