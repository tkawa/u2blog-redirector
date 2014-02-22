require 'bundler'
Bundler.require

use Rack::Rewrite do
  #    http://blog.u2plus.jp/wp-content/uploads/:path
  # -> http://u2blog-assets.s3-ap-northeast-1.amazonaws.com/:path
  r301 %r{/wp-content/uploads/(.*)}, 'http://u2blog-assets.s3-ap-northeast-1.amazonaws.com/$1'

  #    http://blog.u2plus.jp/:category/:name
  # -> http://u2blog.u2plus.jp/entry/:name
  r301 %r{/([^/]+)/(.*)}, 'http://u2blog.u2plus.jp/entry/$2'

  #    http://blog.u2plus.jp/:page
  # -> http://u2blog.u2plus.jp/entry/:page
  r301 %r{/([^\?][^/]*)}, 'http://u2blog.u2plus.jp/entry/$1'

  #    http://blog.u2plus.jp/
  # -> http://u2blog.u2plus.jp/
  r301 %r{/(\?.*)?}, 'http://u2blog.u2plus.jp/$1'

  # miss
  r302 %r{.*}, 'http://u2plus.jp/?from=$&'
end

# do nothing
run ->(env) {}
