--
-- Author: LXL
-- Date: 2016-11-07 09:57:48
--
local defaultData = import(".CreateDefaultData")

local createData = {}
local boxlist

function createData:init(ckboxlist)
    boxlist = ckboxlist
end

function createData:getGameTypeData(gameType)
    return defaultData[gameType]
end

function createData:getPlayerNum()
    for k,box in ipairs(boxlist[2]) do
        if box:isSelected() then
            return 5-k
        end
    end
end

function createData:getGameNum()
    for k,box in ipairs(boxlist[1]) do
        if box:isSelected() then
            return k==1 and 8 or 16
        end
    end
end

function createData:isSelected(btn)
    if not btn.isSelected then
        local tick = helper.findNodeByName(btn,"tick")
        return tick:isVisible()
    else
        return btn:isSelected()
    end
end

function createData:getGameRule(tab)
    local data = {}
    if tab == 1 then
        if boxlist[3][1]:isSelected() then
            data.game_type = 1
        else
            data.game_type = 2
        end
    elseif tab == 4 or tab == 2 then
        data.game_type = 2
    end
    --庄闲
    if 1 == tab then
        data.idle       =  self:isSelected(boxlist[5][1])
    end
    --胡7对
    if 4 == tab then
        data.seven_hu   = self:isSelected(boxlist[3][2])
    elseif 2 == tab then
        data.seven_hu   = self:isSelected(boxlist[4][3])
    elseif 1 == tab then
        data.seven_hu   = self:isSelected(boxlist[5][2])
    end
    --癞子
    if 2 == tab then
        data.laizi      = not(self:isSelected(boxlist[3][1]))
        data.baiban = self:isSelected(boxlist[3][2])
        data.kaiwang = self:isSelected(boxlist[3][3])
    elseif 1 == tab then
        data.laizi      = self:isSelected(boxlist[5][3])
    end
    --可抢杠
    if 2 == tab then
        data.qiang_gang = self:isSelected(boxlist[4][1])
    elseif 1 == tab then
        data.qiang_gang = self:isSelected(boxlist[4][1])
    elseif 3 == tab then
        data.qiang_gang = self:isSelected(boxlist[5][1])    
    end
    data.find_bird  = 0
    data.type       = self.m_type or 1
    if(self.m_jewel)then
        data.jewel      = self.m_jewel
    end
    if self.m_clubData then
        data.clubData = self.m_clubData
    end
    if(Is_Cheat_Set and self.m_isCheat)then
        data.is_cheat_room = self.m_isCheat
    end
    --捉鸟或扎码
    if tab == 4 then
        for k,box in ipairs(boxlist[5]) do
            if box:isSelected() then
                --data.find_bird = k + 1
                data.find_bird = k*2
            end
        end
    elseif 1 == tab then
        if boxlist[7][1]:isSelected() then --一马全中
            data.find_bird = 1
        end
        for k,box in ipairs(boxlist[6]) do
            if box:isSelected() then
                data.find_bird = k*2
            end
        end
    elseif 2 == tab then
        if boxlist[8][1]:isSelected() then --爆炸马
            data.find_bird = 1
        end
        for k,box in ipairs(boxlist[7]) do
            if box:isSelected() then
                data.find_bird = k*2
            end
        end
        -- for k,box in ipairs(boxlist[7]) do
        --     if box:isSelected() then
        --         if k == 3 then
        --             data.find_bird = 1
        --         elseif k == 4 then
        --             data.follow_point = 1
        --         else
        --             data.find_bird = k*2
        --         end
        --     end
        -- end
    elseif 3 == tab then
         if boxlist[7][1]:isSelected() then --爆炸马
            data.find_bird = 1
        end
        for k,box in ipairs(boxlist[8]) do
            if box:isSelected() then
                data.find_bird = k*2
            end
        end       
    else
        for k,box in ipairs(boxlist[5]) do
            if box:isSelected() then
                data.find_bird = k*2
            end
        end
    end
    if 1 == tab and boxlist[5][4] and self:isSelected(boxlist[5][4]) and data.find_bird > 0 then
        data.bird_point = 2
    elseif tab ~= 3 and boxlist[4][4] and self:isSelected(boxlist[4][4]) and data.find_bird > 0 then
        --data.bird_point = 2
    end
    --特有的规则
    if 4 == tab then
        data.hongzhong = true
        data.ming_gang = self:isSelected(boxlist[3][3])
        if boxlist[4][1]:isSelected() then --一码全中
            data.find_bird = 1
        end
    elseif 3 == tab then
        data.laizi      = not(self:isSelected(boxlist[3][1]))
        data.baiban = self:isSelected(boxlist[3][2])
        data.kaiwang = self:isSelected(boxlist[3][3])

        data.no_wan = self:isSelected(boxlist[4][1])
        data.no_feng = self:isSelected(boxlist[4][2])
        data.all_card = self:isSelected(boxlist[4][3])

        --data.ming_gang = true
        data.qiang_gang_quanbao = self:isSelected(boxlist[5][2])
        data.gang_bao_quanbao = self:isSelected(boxlist[5][3])

        data.again_banker = self:isSelected(boxlist[6][1])
        data.no_laizi_hu_4_point = self:isSelected(boxlist[6][2])
        data.seven_hu_4_point = self:isSelected(boxlist[6][3])
        data.seven_hu = true
    elseif 5 == tab then
        data.kaiwang = self:isSelected(boxlist[3][1])
        data.firstHu = self:isSelected(boxlist[3][2])
        for k,box in ipairs(boxlist[4]) do
            if box:isSelected() then
                data.bighu = k + 5
                break
            end
        end
    elseif 6 == tab then
        data.huangzhuang = self:isSelected(boxlist[3][2])
        if boxlist[4][1]:isSelected() then
            data.find_bird = 1
        end
    elseif 1 == tab then
        data.ming_gang = self:isSelected(boxlist[4][2])
    elseif 2 == tab then
        data.ming_gang = self:isSelected(boxlist[4][2])
        data.qiang_gang_quanbao = self:isSelected(boxlist[5][1])
        data.gang_bao_quanbao = self:isSelected(boxlist[5][2])
        data.follow_banker = self:isSelected(boxlist[6][1])
        data.again_banker = self:isSelected(boxlist[6][2])
        data.no_feng = self:isSelected(boxlist[6][3])
        data.follow_point = self:isSelected(boxlist[8][2])
        if data.laizi == true then
            data.no_laizi_hu_4_point = true
        end
    end
    self:setGameTypeData(tab)
    data.roomData = defaultData[tab]

    return json.encode(data)
end

function createData:setGameTypeData(gameType)
    for i,data in ipairs(boxlist) do
        for j,v in ipairs(data) do
            -- local isShow = helper.findNodeByName(v:getParent(),"item_img")
            -- if(not isShow)then
            --      isShow = helper.findNodeByName(v,"Image")
            -- end
            local isShow = self:isSelected(v)
            -- if isShow:isVisible() then
            if isShow then
                defaultData[gameType][i][j] = 1
            else
                defaultData[gameType][i][j] = 0
            end
        end
    end
    dump(LocalData.data.createRoomData,"LocalData.data.createRoomData set")

    LocalData.data._mahjongTypeTab = self.m_type or LocalData.data._mahjongTypeTab or 1
    LocalData:save()
end

function createData:getUseNum()
    return self:getGameNum() / 8
end

function createData:setMahjongType( type )
    self.m_type = type
end

function createData:setNeedJewel(num)
    self.m_jewel = num
end

function createData:setClubData(data)
    self.m_clubData = data
end

function createData:setCheatRoom(type)
    self.m_isCheat = type
end
return createData
