if Config.Updates.CheckForUpdates then
    PerformHttpRequest('https://api.github.com/repos/encorerp/encore_radio/releases/latest', function(errorCode, resultData, resultHeaders)
        Citizen.Wait(1500)

        if not resultData then
            return
        end

        local results       = json.decode(resultData)
        local latestVersion = results.tag_name

        local localVersion  = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not localVersion then
            localVersion = 'Unkwn'
        end

        print('')
        print('##########################')
        print('#      encore_radio      #')
        print('##########################')
        print('#                        #')

        print('# Current Version: ' .. latestVersion .. ' #')

        if localVersion == latestVersion then
            print('# Your Version:    ^2' .. localVersion .. '^0 #')
        else
            print('# Your Version:    ^1' .. localVersion .. '^0 #')
        end

        print('#                        #')
        print('##########################')
    end, 'GET', nil, {
        ['Accept']     = 'application/json',
        ['User-Agent'] = 'Encore RP Version Checker',
    })
end