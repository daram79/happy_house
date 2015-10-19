$(document).on 'page:load page:restore', ->
# Universal Analyticsの場合
  if window.ga?
    ga('set', 'location', location.href.split('#')[0])
    ga('send', 'pageview')
   
  # 標準のアナリティクスの場合
  if window._gaq?
    _gaq.push(['_trackPageview'])