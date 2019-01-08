module.exports = (robot) ->

  robot.respond /いやし(|！)/i, (msg) ->
    iyashi = msg.random [
      "ぎゅー"
      "ぎゅーっ！"
      "もうすこしふぁいと！"
      "あらー"
      "いやし〜" 
    ]
    msg.reply "#{iyashi}"