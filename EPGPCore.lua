
GuildRoster()
playerarray = {}
local MLEPGP, events = CreateFrame("frame"), {};
function events:GUILD_ROSTER_UPDATE(...)
    local numTotal = GetNumGuildMembers()
    for index = 1 , numTotal
        do
            local fullname = GetGuildRosterInfo(index)
            local ep,gp = getEPGP(index)
            playerarray[fullname] = {}
            playerarray[fullname]["ep"] = ep
            playerarray[fullname]["gp"] = gp
            print(playerarray[fullname]["ep"])
        end
    end

function getEPGP(index)
    local _,_,_,_,_,_,_,officerNote = GetGuildRosterInfo(index)
    if officerNote == nil then
        GuildRosterSetOfficerNote(index, "0,0")
        local ep = 0
        local gp = 0
        return ep, gp
    end
    local ep, gp = strsplit("," , officerNote)
    ep = tonumber(ep)
    gp = tonumber(gp)
    if (ep == nil or gp == nil) then
        GuildRosterSetOfficerNote(index, "0,0")
        local ep = 0
        local gp = 0
        return ep, gp
    end
    return ep, gp
end

MLEPGP:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...);
end);
for k, v in pairs(events) do
 MLEPGP:RegisterEvent(k);
end