
GuildRoster()
playerarray = {}
local MLEPGP, events = CreateFrame("frame"), {};
function events:GUILD_ROSTER_UPDATE(...)
    local numTotal = GetNumGuildMembers()
    for index = 1 , numTotal
        do
            local fullname,_,_,level,class = GetGuildRosterInfo(index)
            local ep,gp = getEPGP(index)
            name = stripServer(fullname)
            playerarray[name] = {}
            playerarray[name]["ep"] = ep
            playerarray[name]["gp"] = gp
            playerarray[name]["level"] = level
            playerarray[name]["class"] = class
            playerarray[name]["server"] = server
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

function stripServer(fullname)
    local name, server = strsplit("-" , fullname)
    return name, server
end

MLEPGP:SetScript("OnEvent", function(self, event, ...)
    events[event](self, ...);
end);

for k, v in pairs(events) do
    MLEPGP:RegisterEvent(k);
end