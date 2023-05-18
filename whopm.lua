local eventHandler;
local PM_Player = "Player";

local FONT, FONTSIZE, FONTCOLOR = "Fonts\\Arialn.ttf", 32, {73, 0, 5}; -- 0, 1, 1
local g_MsgSync;

-- /* hud message */
do
    local function showsynchudmsg(duration, time, justify, width, height)
        local hud = CreateFrame("ScrollingMessageFrame", nil, UIParent);
        hud:SetMaxLines(1);
        hud:SetFadeDuration(duration);
        hud:SetTimeVisible(time);
        hud:SetJustifyH(justify);
        hud:SetSize(width, height);
        hud:SetFont(FONT, FONTSIZE);
        hud:SetShadowColor(0, 0, 0, 1);
        hud:SetShadowOffset(1, -1);
        hud:SetTextColor(unpack(FONTCOLOR));
        hud:SetPoint("CENTER", UIParent, "CENTER", 0, 360);
        hud:SetFrameStrata("HIGH");
        hud:Hide(); -- скрыть фрейм при инициализации

        return hud;
    end

    g_MsgSync = showsynchudmsg(4, 5, "CENTER", 1920, FONTSIZE);
end

-- /* fire event */
do
    eventHandler = CreateFrame("Frame");
	eventHandler:RegisterEvent("CHAT_MSG_WHISPER");
    eventHandler:SetScript("OnEvent", function(self, event, ...)
        local func = self[event];
        if type(func) == "function" then
            func(self, event, ...);
        end
    end);
end

function eventHandler:CHAT_MSG_WHISPER(_, msg, author)
    g_MsgSync:AddMessage(author .. ": " .. msg); -- выводим сообщение отправителя в личку и текст сообщения
    g_MsgSync:Show();
end

print("|cffc41f3bWho write me?|r: |cffffff00loaded|r")