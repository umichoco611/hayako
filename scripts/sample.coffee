module.exports = (robot) ->

  robot.respond /いやし！/i, (msg) ->
    msg.reply msg.random ["ぎゅー" ,"もうすこしふぁいと！","いやし〜","あらー"]