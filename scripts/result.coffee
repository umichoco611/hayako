resultList = []

      hasSameTask = (list,taskName,result) ->
        if list.length == 0
          return false
        for obj in list
          taskInList = Object.keys(obj)[0]
          if taskName == taskInList
            obj[taskInList] += result[taskName]
            return true
        return false

      for result in tasks
        task = Object.keys(result)[0]

        if not hasSameTask(resultList, task, result)
          resultList.push(result)
