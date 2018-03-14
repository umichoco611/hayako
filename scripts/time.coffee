#ハッシュタグを受けとって返す
module.exports = (robot) ->

    robot.hear /#___/, (msg) ->  
        msg.send msg.message.text 


#時間を集計する
    robot.respond /集計して/i, (msg) ->
        today = new Date()
        oldestMilliSec = new Date(today.getFullYear(), today.getMonth(), today.getDate()).getTime() / 1000


# 当日０時以降の履歴のみ取得する。
        request = msg.http('https://slack.com/api/channels.history')
                    .query(token: process.env.HUBOT_SLACK_TOKEN, channel:process.env.CHANNEL_ID, oldest:oldestMilliSec)
                    .post()    

        request (err, res, body) ->
        json = JSON.parse body
        contents = json.messages
                    .filter((v) -> v.user == process.env.USER_ID)
                    .filter((z) -> z.text.startsWith("#___"))
                    .reverse()

        if contents.length == 0
            msg.send "ないよ"
            return
        
        formatTime = (second) ->
            result = ''
        #時間計算
        hour = Math.floor(seconds / 60 / 60)
        min = Math.floor(seconds / 60 % 60)
        sec = Math.floor(seconds % 60)

        if hour > 0
            result += hour + '時'
        if min > 0
            result += min + '分'
        if sec > 0
            result += sec + '秒'
        result

        tasks = contents.map((val,i)->
            
            if i == contents.length-1
                obj = {}
                task = val.text.slice(4)
                cost = (Date.now()/ 1000 - val.ts)
                obj[task] = cost
                return obj 
            
            if (i + 1 < contents.length)
                obj = {}
                task = val.text.slice(4)
                cost = (contents[i+1].ts - val.ts)
                obj[task] = cost
                return obj 
    )

#同じ名前のタスクは合算する
resultList =[]

hasSameTask = (list,taskName,result) ->
            if list.length == 0
                return false
            for  obj in list
                taskInList = Object.keys(obj)[0]
                if taaskName == taskInList
                    obj[taskInList] += result[taskName]
                    return true
            return false

            for result in tasks
                task = Object.keys(resul)[0]

                if not hasSameTask(resultList, task, result)
                    resultList.push(result)

